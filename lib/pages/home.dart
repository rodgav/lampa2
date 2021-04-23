import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lampa2/bloc/atractivos/atractivos_bloc.dart';
import 'package:lampa2/bloc/ciudades/ciudades_bloc.dart';
import 'package:lampa2/bloc/distrititos/distritos_bloc.dart';
import 'package:lampa2/bloc/gastronomia/gastronomia_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:lampa2/bloc/pages/pages_bloc.dart';
import 'package:lampa2/pages/camara.dart';
import 'package:lampa2/pages/ciudad.dart';
import 'package:lampa2/pages/mapa.dart';
import 'package:lampa2/pages/notFound.dart';
import 'package:lampa2/widgets/responsive_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    context.read<CiudadesBloc>().add(OnCiudadesEventChange());
    context.read<DistritosBloc>().add(OnDistritosEventChange());
    context.read<AtractivosBloc>().add(OnAtractivosEventChange());
    context.read<GastronomiaBloc>().add(OnGastronomiaEventChange());
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool web = size.width > 800;
    return Scaffold(
      body: Column(
        children: [
          web ? _bar(web, size, context) : Container(),
          Expanded(
            child: BlocBuilder<PagesBloc, PagesState>(builder: (_, state) {
              return ResponsiveWidget(
                largeScreen: state.page == 'ciudad'
                    ? CiudadPage(web: true)
                    : state.page == 'mapa'
                        ? MapaPage(web: true)
                        : state.page == 'mapa'
                            ? MapaPage(web: true)
                            : state.page == 'camara' && !kIsWeb
                                ? CamaraPage(web: true)
                                : NotFoundPage(),
                mediumScreen: state.page == 'ciudad'
                    ? CiudadPage(web: true)
                    : state.page == 'mapa'
                        ? MapaPage(web: true)
                        : state.page == 'mapa'
                            ? MapaPage(web: true)
                            : state.page == 'camara' && !kIsWeb
                                ? CamaraPage(web: true)
                                : NotFoundPage(),
                smallScreen: state.page == 'ciudad'
                    ? CiudadPage(web: false)
                    : state.page == 'mapa'
                        ? MapaPage(web: false)
                        : state.page == 'mapa'
                            ? MapaPage(web: false)
                            : state.page == 'camara' && !kIsWeb
                                ? CamaraPage(web: true)
                                : NotFoundPage(),
              );
            }),
          ),
          web ? Container() : _bar(web, size, context),
        ],
      ),
    );
  }

  Widget _bar(bool web, Size size, BuildContext context) => Container(
        width: size.width,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          mainAxisAlignment:
              web ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Colors.blue,
              child: InkWell(
                child: Column(
                  children: [
                    Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Mapa',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  context.beamToNamed('/home/mapa');
                },
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Material(
              color: Colors.blue,
              child: InkWell(
                child: Column(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Ciudad',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  context.beamToNamed('/home/ciudad');
                },
              ),
            ),
            SizedBox(
              width: 30,
            ),
            web
                ? Container()
                : Material(
                    color: Colors.blue,
                    child: InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'AR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        context.beamToNamed('/home/camara');
                      },
                    ),
                  ),
          ],
        ),
      );
}
