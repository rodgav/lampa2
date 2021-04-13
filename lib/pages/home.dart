import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lampa2/bloc/pages/pages_bloc.dart';
import 'package:lampa2/pages/ciudad.dart';
import 'package:lampa2/pages/mapa.dart';
import 'package:lampa2/pages/notFound.dart';
import 'package:lampa2/widgets/responsive_widget.dart';

class HomePage extends StatelessWidget {
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
                            : NotFoundPage(),
                mediumScreen: state.page == 'ciudad'
                    ? CiudadPage(web: true)
                    : state.page == 'mapa'
                        ? MapaPage(web: true)
                        : state.page == 'mapa'
                            ? MapaPage(web: true)
                            : NotFoundPage(),
                smallScreen: state.page == 'ciudad'
                    ? CiudadPage(web: false)
                    : state.page == 'mapa'
                        ? MapaPage(web: false)
                        : state.page == 'mapa'
                            ? MapaPage(web: false)
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
                            'Camara',
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
