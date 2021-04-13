class AtractivosModel {
  List<Atractivos> _atractivos;

  AtractivosModel({List<Atractivos> atractivos}) {
    this._atractivos = atractivos;
  }

  List<Atractivos> get atractivos => _atractivos;
  set atractivos(List<Atractivos> atractivos) => _atractivos = atractivos;

  AtractivosModel.fromJson(Map<String, dynamic> json) {
    if (json['atractivos'] != null) {
      _atractivos = new List<Atractivos>.empty(growable: true);
      json['atractivos'].forEach((v) {
        _atractivos.add(new Atractivos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._atractivos != null) {
      data['atractivos'] = this._atractivos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Atractivos {
  String _nombre;
  String _distancia;
  String _imagen;
  String _video;
  String _descripcion;
  double _latitud;
  double _longitud;
  String _altitud;

  Atractivos(
      {String nombre,
        String distancia,
        String imagen,
        String video,
        String descripcion,
        double latitud,
        double longitud,
        String altitud}) {
    this._nombre = nombre;
    this._distancia = distancia;
    this._imagen = imagen;
    this._video = video;
    this._descripcion = descripcion;
    this._latitud = latitud;
    this._longitud = longitud;
    this._altitud = altitud;
  }

  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get distancia => _distancia;
  set distancia(String distancia) => _distancia = distancia;
  String get imagen => _imagen;
  set imagen(String imagen) => _imagen = imagen;
  String get video => _video;
  set video(String video) => _video = video;
  String get descripcion => _descripcion;
  set descripcion(String descripcion) => _descripcion = descripcion;
  double get latitud => _latitud;
  set latitud(double latitud) => _latitud = latitud;
  double get longitud => _longitud;
  set longitud(double longitud) => _longitud = longitud;
  String get altitud => _altitud;
  set altitud(String altitud) => _altitud = altitud;

  Atractivos.fromJson(Map<String, dynamic> json) {
    _nombre = json['nombre'];
    _distancia = json['distancia'];
    _imagen = json['imagen'];
    _video = json['video'];
    _descripcion = json['descripcion'];
    _latitud = json['latitud'];
    _longitud = json['longitud'];
    _altitud = json['altitud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['distancia'] = this._distancia;
    data['imagen'] = this._imagen;
    data['video'] = this._video;
    data['descripcion'] = this._descripcion;
    data['latitud'] = this._latitud;
    data['longitud'] = this._longitud;
    data['altitud'] = this._altitud;
    return data;
  }
}
