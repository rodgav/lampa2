part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;
  final Map<String, Polyline> polilynes;
  final List<Marker> markers;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = false,
      this.seguirUbicacion = false,
      this.ubicacionCentral,
      Map<String, Polyline> polilynes,
        List<Marker> markers})
      : this.polilynes = polilynes ?? Map(),
        this.markers = markers ?? [];

  MapaState copyWhit(
          {bool mapaListo,
          bool dibujarRecorrido,
          bool seguirUbicacion,
          LatLng ubicacionCentral,
          Map<String, Polyline> polilynes,
            List<Marker> markers}) =>
      MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
          seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
          ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
          polilynes: polilynes ?? this.polilynes,
          markers: markers ?? this.markers);
}
