import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lampa2/themes/map.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';

part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _googleMapController;

  Polyline _miRuta = Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._googleMapController = controller;

      this._googleMapController.setMapStyle(jsonEncode(MapTheme));

      add(OnMapaListo());
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
    }else if(event is OnModioMapa){
      yield state.copyWhit(ubicacionCentral: event.centroMapa);
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
}
