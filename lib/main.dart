import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lampa2/bloc/pages/pages_bloc.dart';
import 'package:lampa2/helpers/zoomSlideUpTransitionBuilder.dart';
import 'package:lampa2/locations/home.dart';
import 'package:lampa2/locations/splash.dart';
import 'package:lampa2/pages/notFound.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PagesBloc()),
        ],
        child: MaterialApp.router(
          title: 'Ciudad de Lampa',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: ZoomSlideUpTransitionsBuilder(),
              TargetPlatform.android: ZoomSlideUpTransitionsBuilder(),
            }),
          ),
          routerDelegate: BeamerRouterDelegate(
            locationBuilder: (state) {
              if (state.uri.pathSegments.contains('splash')) {
                return SplashLocation(state);
              }
              if (state.uri.pathSegments.contains('home')) {
                return HomeLocation(state);
              }
              return SplashLocation(state);
            },
            notFoundPage: notFoundPage,
          ),
          routeInformationParser: BeamerRouteInformationParser(),
        ),);
  }
  final notFoundPage = BeamPage(child: NotFoundPage());
}