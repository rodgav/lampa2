import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lampa2/bloc/atractivo/atractivo_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:lampa2/helpers/calculando_alerta.dart';
import 'package:lampa2/models/atractivos.dart';
import 'package:lampa2/services/traffic_service.dart';
import 'package:lampa2/themes/map.dart';
import 'package:lampa2/widgets/bottomSheet.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:polyline/polyline.dart' as Poly;

part 'mapa_event.dart';

part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _googleMapController;

  Polyline _miRuta = Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent);

  Polyline _miRutaDestino = Polyline(
      polylineId: PolylineId('mi_ruta_destino'),
      width: 4,
      color: Colors.black87);

  void initMapa(GoogleMapController controller, List<Atractivos> atractivos,
      BuildContext context) {
    if (!state.mapaListo) {
      this._googleMapController = controller;

      this._googleMapController.setMapStyle(jsonEncode(MapTheme));

      add(OnMapaListo());
      add(OnCrearMarkers(atractivos, context));
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._googleMapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaListo) {
      yield state.copyWhit(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      yield* this._OnNuevaUbicacion(event);
    } else if (event is OnMarcarRecorrido) {
      yield* this._OnMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      yield* this._OnSeguirUbicacion(event);
    } else if (event is OnModioMapa) {
      yield state.copyWhit(ubicacionCentral: event.centroMapa);
    } else if (event is OnCrearRutaInicioDestino) {
      yield* this._OnCrearRutaInicioDestino(event);
    } else if (event is OnCrearMarkers) {
      yield* this._OnCrearMarkers(event);
    }
  }

  Stream<MapaState> _OnNuevaUbicacion(OnNuevaUbicacion event) async* {
    if (state.seguirUbicacion) {
      this.moverCamara(event.ubicacion);
    }
    final points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);
    final currentPolylines = state.polilynes;
    currentPolylines['mi_ruta'] = this._miRuta;
    yield state.copyWhit(polilynes: currentPolylines);
  }

  Stream<MapaState> _OnMarcarRecorrido(OnMarcarRecorrido event) async* {
    if (state.dibujarRecorrido) {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
    } else {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    }
    final currentPolylines = state.polilynes;
    currentPolylines['mi_ruta'] = this._miRuta;
    yield state.copyWhit(
        dibujarRecorrido: !state.dibujarRecorrido, polilynes: currentPolylines);
  }

  Stream<MapaState> _OnSeguirUbicacion(OnSeguirUbicacion event) async* {
    if (!state.seguirUbicacion) {
      this.moverCamara(this._miRuta.points.last);
    }
    yield state.copyWhit(seguirUbicacion: !state.seguirUbicacion);
  }

  Stream<MapaState> _OnCrearRutaInicioDestino(
      OnCrearRutaInicioDestino event) async* {
    this._miRutaDestino =
        this._miRutaDestino.copyWith(pointsParam: event.rutaCoordenadas);
    final currentPolylines = state.polilynes;
    currentPolylines['mi_ruta_destino'] = this._miRutaDestino;

    List<Marker> markers = state.markers;
    double kilometros = event.distancia / 1000;
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;
    markers.add(Marker(
        markerId: MarkerId('Inicio'),
        position: event.rutaCoordenadas.first,
        infoWindow: InfoWindow(
            title: 'Mi ubicación',
            snippet:
                '${(event.duration / 60).floor()} minutos\n$kilometros km')));
    yield state.copyWhit(polilynes: currentPolylines, markers: markers);
  }

  Stream<MapaState> _OnCrearMarkers(OnCrearMarkers event) async* {
    final markers = event.atractivos
        .map((e) => Marker(
            markerId: MarkerId(e.nombre),
            position: LatLng(e.latitud, e.longitud),
            infoWindow: InfoWindow(
                title: e.nombre,
                snippet: e.descripcion,
                onTap: () {
                  event.context.read<AtractivoBloc>().add(OnReciveAtractivo(e));
                  BottomSheetWid(context: event.context);
                  //_dibujarRuta(e.nombre, LatLng(e.latitud, e.longitud), event.context);
                })))
        .toList();

    yield state.copyWhit(markers: markers);
  }
}
