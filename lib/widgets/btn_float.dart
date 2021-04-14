import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lampa2/bloc/mapa/mapa_bloc.dart';
import 'package:lampa2/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class BtnFloat extends StatelessWidget {
  IconData iconData;
  VoidCallback onPressed;

  BtnFloat({@required this.iconData, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            iconData,
            color: Colors.black87,
          ),
          onPressed: this.onPressed,
        ),
      ),
    );
  }
}
