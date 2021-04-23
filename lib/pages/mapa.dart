import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lampa2/bloc/atractivos/atractivos_bloc.dart';
import 'package:lampa2/bloc/mapa/mapa_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:lampa2/widgets/btn_float.dart';

class MapaPage extends StatelessWidget {
  bool web;

  MapaPage({@required this.web});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
      builder: (context, state) => _crearMapa(context, state),
    );
  }

  Widget _crearMapa(BuildContext context, MiUbicacionState state) {
    if (!state.existeUbicacion)
      return Center(
        child: Text('Ubicando...'),
      );
    final mapaBloc = context.read<MapaBloc>();
    final miUbicacionBloc = context.read<MiUbicacionBloc>();
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final cameraPosition = CameraPosition(target: state.ubicacion, zoom: 8);

    return Scaffold(
        body: BlocBuilder<AtractivosBloc, AtractivosState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case AtractivosInitial:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case AtractivosLoading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case AtractivosLoaded:
                final atractivos =
                    (state as AtractivosLoaded).atractivosModel.atractivos;
                return BlocBuilder<MapaBloc, MapaState>(
                  builder: (_, __) {
                    return GoogleMap(
                      initialCameraPosition: cameraPosition,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      onMapCreated: (GoogleMapController googleMapController) {
                        mapaBloc.initMapa(
                            googleMapController, atractivos, context);
                      },
                      polylines: mapaBloc.state.polilynes.values.toSet(),
                      markers: mapaBloc.state.markers.toSet(),
                      /*onCameraMove: (cameraPosition){
                        mapaBloc.add(OnModioMapa(cameraPosition.target));
                      },*/
                    );
                  },
                );
              case AtractivosError:
                final error = (state as AtractivosError).error;
                return Center(
                  child: Text(error),
                );
              default:
                return Center(
                  child: Text('Estado no reconocido'),
                );
            }
          },
        ),
        floatingActionButton: BlocBuilder<MapaBloc, MapaState>(
            builder: (_, state) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BtnFloat(
                      maxRadius: 25,
                      iconData: Icons.my_location,
                      onPressed: () {
                        final destino = miUbicacionBloc.state.ubicacion;
                        mapaBloc.moverCamara(destino);
                      },
                    ),
                    /*BtnFloat(
                      maxRadius: 25,
                      iconData: Icons.more_horiz,
                      onPressed: () {
                        mapaBloc.add(OnMarcarRecorrido());
                      },
                    ),*/
                    BtnFloat(
                      maxRadius: 25,
                      iconData: state.seguirUbicacion
                          ? Icons.directions_run
                          : Icons.accessibility_new,
                      onPressed: () {
                        mapaBloc.add(OnSeguirUbicacion());
                      },
                    ),
                  ],
                )));
  }
}
