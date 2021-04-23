import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        context.beamToNamed('/home/mapa');
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return Center(
              child: Text(snapshot.data),
            );
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: Duration(milliseconds: 800),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeInRight(
                  duration: Duration(milliseconds: 1600),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 2400),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    return Future.delayed(Duration(milliseconds: 3000), () async {
      if (kIsWeb) {
        final permisoGPSweb = await Geolocator.checkPermission();
        if (permisoGPSweb == LocationPermission.always ||
            permisoGPSweb == LocationPermission.whileInUse) {
          context.beamToNamed('/home/mapa');
          return 'mapa web';
        } else {
          context.beamToNamed('/accesogps');
          return 'Activar GPS,clic en el boton o clic candado verde al costado de la url.';
        }
      } else {
        try {
          //todo:permiso gps
          final permisoGPS =
              await Permission.location.isGranted;
          //todo:permiso camara
          final permisoCamara = await Permission.camera.isGranted;
          //todo: GPS activo
          final gpsActivo = await Geolocator.isLocationServiceEnabled();
          if (permisoGPS && gpsActivo && permisoCamara) {
            context.beamToNamed('/home/mapa');
            return 'mapa';
          } else {
            context.beamToNamed('/accesogps');
            return 'Active el GPS';
          }
        } catch (e) {
          debugPrint('error $e');
        }
      }
    });
  }
}
