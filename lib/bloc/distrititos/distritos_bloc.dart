import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lampa2/bloc/repository.dart';
import 'package:lampa2/models/ciudades.dart';
import 'package:meta/meta.dart';

part 'distritos_event.dart';
part 'distritos_state.dart';

class DistritosBloc extends Bloc<DistritosEvent, DistritosState> {
  DistritosBloc({@required this.repository}) : super(DistritosInitial());
  final Repository repository;
  @override
  Stream<DistritosState> mapEventToState(
    DistritosEvent event,
  ) async* {
    if (event is OnDistritosEventChange) {
      yield DistritosLoading();
      try {
        CiudadesModel serviciosModel = await repository.getDistritos();
        yield DistritosLoaded(serviciosModel);
      } catch (e) {
        yield DistritosError('Ocurrio un error');
      }
    }
  }
}
