class GastronomiaModel {
  List<Gastronomia> _gastronomia;

  GastronomiaModel({List<Gastronomia> gastronomia}) {
    this._gastronomia = gastronomia;
  }

  List<Gastronomia> get gastronomia => _gastronomia;
  set gastronomia(List<Gastronomia> gastronomia) => _gastronomia = gastronomia;

  GastronomiaModel.fromJson(Map<String, dynamic> json) {
    if (json['gastronomia'] != null) {
      _gastronomia = new List<Gastronomia>.empty(growable: true);
      json['gastronomia'].forEach((v) {
        _gastronomia.add(new Gastronomia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._gastronomia != null) {
      data['gastronomia'] = this._gastronomia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gastronomia {
  String _nombre;
  String _imagen;

  Gastronomia({String nombre, String imagen}) {
    this._nombre = nombre;
    this._imagen = imagen;
  }

  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get imagen => _imagen;
  set imagen(String imagen) => _imagen = imagen;

  Gastronomia.fromJson(Map<String, dynamic> json) {
    _nombre = json['nombre'];
    _imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['imagen'] = this._imagen;
    return data;
  }
}
