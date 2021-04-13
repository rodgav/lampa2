import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lampa2/bloc/repository.dart';
import 'package:lampa2/models/ciudades.dart';
import 'package:meta/meta.dart';

part 'ciudades_event.dart';
part 'ciudades_state.dart';

class CiudadesBloc extends Bloc<CiudadesEvent, CiudadesState> {
  CiudadesBloc({@required this.repository}) : super(CiudadesInitial());
  final Repository repository;
  @override
  Stream<CiudadesState> mapEventToState(
    CiudadesEvent event,
  ) async* {
    if (event is OnCiudadesEventChange) {
      yield CiudadesLoading();
      try {
        CiudadesModel serviciosModel = await repository.getCiudades();
        yield CiudadesLoaded(serviciosModel);
      } catch (e) {
        yield CiudadesError('Ocurrio un error');
      }
    }
  }
}
