import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lampa2/bloc/atractivo/atractivo_bloc.dart';
import 'package:lampa2/bloc/atractivos/atractivos_bloc.dart';
import 'package:lampa2/bloc/ciudades/ciudades_bloc.dart';
import 'package:lampa2/bloc/distrititos/distritos_bloc.dart';
import 'package:lampa2/bloc/gastronomia/gastronomia_bloc.dart';
import 'package:lampa2/bloc/mapa/mapa_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:lampa2/bloc/pages/pages_bloc.dart';
import 'package:lampa2/bloc/repository.dart';
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
        BlocProvider(create: (_) => AtractivosBloc(repository: Repository())),
        BlocProvider(create: (_) => CiudadesBloc(repository: Repository())),
        BlocProvider(create: (_) => DistritosBloc(repository: Repository())),
        BlocProvider(create: (_) => GastronomiaBloc(repository: Repository())),
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => AtractivoBloc()),
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
      ),
    );
  }

  final notFoundPage = BeamPage(child: NotFoundPage());
}
