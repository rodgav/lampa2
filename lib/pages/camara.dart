import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CamaraPage extends StatelessWidget {
  bool web;

  CamaraPage({@required this.web});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future checkCamera(BuildContext context) async {
    //todo:permiso gps
    final permisoCamera = await Permission.camera.isGranted;
    //todo: GPS activo
    if (permisoCamera) {
      return 'activo';
    } else if (!permisoCamera) {
      return 'Es necesario el permiso de GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
