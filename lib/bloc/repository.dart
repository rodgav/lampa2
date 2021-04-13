import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lampa2/models/atractivos.dart';
import 'package:lampa2/models/ciudades.dart';
import 'package:lampa2/models/gastronomia.dart';

class Repository {
  Future<AtractivosModel> getAtractivos() async {
    String atractivos =
        await rootBundle.loadString('assets/jsons/atractivos.json');
    return AtractivosModel.fromJson(jsonDecode(atractivos));
  }

  Future<CiudadesModel> getCiudades() async {
    String ciudades =
        await rootBundle.loadString('assets/jsons/ciudades.json');
    return CiudadesModel.fromJson(jsonDecode(ciudades));
  }

  Future<CiudadesModel> getDistritos() async {
    String distritos =
        await rootBundle.loadString('assets/jsons/distritos.json');
    return CiudadesModel.fromJson(jsonDecode(distritos));
  }

  Future<GastronomiaModel> getGastronomia() async {
    String gastronomia =
        await rootBundle.loadString('assets/jsons/gastronomia.json');
    return GastronomiaModel.fromJson(jsonDecode(gastronomia));
  }
}
