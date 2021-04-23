import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:beamer/beamer.dart';

class AccesoGpsPage extends StatefulWidget {
  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
  String mensaje = 'Es necesario el GPS para usar esta app!!';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        context.beamToNamed('/splash');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  } else {
                    setState(() {
                      this.mensaje =
                          'active el permiso de ubicación al costado de la url (candado verde)';
                    });
                  }
                } else {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.location,
                    Permission.camera,
                  ].request();
                  this.accesoGPS(statuses);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void accesoGPS(Map<Permission, PermissionStatus> statuses) {
    if (statuses[Permission.location].isGranted &&
        statuses[Permission.camera].isGranted) {
      context.beamToNamed('/home/mapa');
    } else {
      openAppSettings();
    }
  }
}
