import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lampa2/pages/acceso_gps.dart';


class AccesoGpsLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/accesogps'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context) => [
    BeamPage(
      key: ValueKey('accesogps'),
      child: AccesoGpsPage(),
    ),
  ];
}