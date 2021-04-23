import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lampa2/pages/acceso_gps.dart';


class AccesoGpsLocation extends BeamLocation {
  AccesoGpsLocation(BeamState state) : super(state);
  @override
  List<String> get pathBlueprints => ['/accesogps'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: ValueKey('accesogps'),
      child: AccesoGpsPage(),
    ),
  ];
}