import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lampa2/pages/splash.dart';


class SplashLocation extends BeamLocation {
  SplashLocation(BeamState state) : super(state);
  @override
  List<String> get pathBlueprints => ['/splash'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
    BeamPage(
      key: ValueKey('splash'),
      child: SplashPage(),
    ),
  ];
}