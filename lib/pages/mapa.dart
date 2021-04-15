import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lampa2/bloc/atractivos/atractivos_bloc.dart';
import 'package:lampa2/bloc/mapa/mapa_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:lampa2/widgets/btn_float.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:beamer/beamer.dart';

class MapaPage extends StatefulWidget {
  bool web;

  MapaPage({@required this.web});

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    //debugPrint('state $state');
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        context.beamToNamed('/splash');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String data = snapshot.data;
            if (data == 'activo') {
              return BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
                builder: (context, state) => _crearMapa(state),
              );
            } else {
              return _permissionApp(data);
            }
          }
          return _permissionApp('Es necesario el GPS para usar esta app!!');
        });
  }

  Future checkGpsLocation(BuildContext context) async {
    if (kIsWeb) {
      final permisoGPSweb = await Geolocator.checkPermission();
      if (permisoGPSweb == LocationPermission.always ||
          permisoGPSweb == LocationPermission.whileInUse) {
        return 'activo';
      } else {
        return 'Activar GPS,clic en el boton o clic candado verde al costado de la url.';
      }
    } else {
      //todo:permiso gps
      final permisoGPS = await Permission.location.isGranted;
      //todo: GPS activo
      final gpsActivo = await Geolocator.isLocationServiceEnabled();
      if (permisoGPS && gpsActivo) {
        return 'activo';
      } else if (!permisoGPS) {
        return 'Es necesario el permiso de GPS';
      } else {
        return 'Active el GPS';
      }
    }
  }

  void accesoGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        context.beamToNamed('/home/mapa');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }

  Widget _permissionApp(String mensaje) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensaje),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              child: Text(
                'Solicitar acceso',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                if (kIsWeb) {
                  await Geolocator.requestPermission();
                  final permisoGPSweb = await Geolocator.checkPermission();
                  if (permisoGPSweb == LocationPermission.always ||
                      permisoGPSweb == LocationPermission.whileInUse) {
                    context.beamToNamed('/home/mapa');
                  }
                } else {
                  final status = await Permission.location.request();
                  this.accesoGPS(status);
                }
              },
            )
          ],
        ),
      );

  Widget _crearMapa(MiUbicacionState state) {
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
