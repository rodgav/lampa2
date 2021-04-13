class CiudadesModel {
  List<Ciudades> _ciudades;

  CiudadesModel({List<Ciudades> ciudades}) {
    this._ciudades = ciudades;
  }

  List<Ciudades> get ciudades => _ciudades;
  set ciudades(List<Ciudades> ciudades) => _ciudades = ciudades;

  CiudadesModel.fromJson(Map<String, dynamic> json) {
    if (json['ciudades'] != null) {
      _ciudades = new List<Ciudades>.empty(growable: true);
      json['ciudades'].forEach((v) {
        _ciudades.add(new Ciudades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._ciudades != null) {
      data['ciudades'] = this._ciudades.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ciudades {
  String _nombre;
  String _distancia;
  String _imagen;

  Ciudades({String nombre, String distancia, String imagen}) {
    this._nombre = nombre;
    this._distancia = distancia;
    this._imagen = imagen;
  }

  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get distancia => _distancia;
  set distancia(String distancia) => _distancia = distancia;
  String get imagen => _imagen;
  set imagen(String imagen) => _imagen = imagen;

  Ciudades.fromJson(Map<String, dynamic> json) {
    _nombre = json['nombre'];
    _distancia = json['distancia'];
    _imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['distancia'] = this._distancia;
    data['imagen'] = this._imagen;
    return data;
  }
}
