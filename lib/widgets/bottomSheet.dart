import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lampa2/bloc/atractivo/atractivo_bloc.dart';
import 'package:lampa2/bloc/mapa/mapa_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:lampa2/helpers/calculando_alerta.dart';
import 'package:lampa2/services/traffic_service.dart';
import 'package:lampa2/widgets/btn_float.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:polyline/polyline.dart' as Poly;

BottomSheetWid({
  @required BuildContext context,
}) {
  showCupertinoModalBottomSheet(
    barrierColor: Colors.black87,
    context: context,
    builder: (context) => ButtomSheet(),
  );
}

class ButtomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height * 0.5,
        child: Scaffold(body: BlocBuilder<AtractivoBloc, AtractivoState>(
          builder: (_, state) {
            final stateA = state.atractivos;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.25,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            width: size.width,
                            imageUrl: stateA.imagen,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: BtnFloat(
                              maxRadius: 20,
                              iconData: Icons.directions,
                              onPressed: () => _dibujarRuta(
                                  stateA.nombre,
                                  LatLng(stateA.latitud, stateA.longitud),
                                  context)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          stateA.nombre,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(stateA.descripcion),
                        SizedBox(
                          height: 5,
                        ),
                        Text(stateA.altitud),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )));
  }

  _dibujarRuta(
      String nombreDestino, LatLng destino, BuildContext context) async {
    calculandoAlerta(context);
    TrafficServices trafficServices = TrafficServices();
    final mapaBloc = context.read<MapaBloc>();
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;

    final drivingResponse =
        await trafficServices.getCoordsInicioyFin(inicio, destino);
    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;
    final List<LatLng> rutaCoords =
        points.map((point) => LatLng(point[0], point[1])).toList();
    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoords, distance, duration, nombreDestino));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
