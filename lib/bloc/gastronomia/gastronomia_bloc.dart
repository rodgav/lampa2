import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lampa2/bloc/repository.dart';
import 'package:lampa2/models/gastronomia.dart';
import 'package:meta/meta.dart';

part 'gastronomia_event.dart';
part 'gastronomia_state.dart';

class GastronomiaBloc extends Bloc<GastronomiaEvent, GastronomiaState> {
  GastronomiaBloc({@required this.repository}) : super(GastronomiaInitial());
  final Repository repository;
  @override
  Stream<GastronomiaState> mapEventToState(
    GastronomiaEvent event,
  ) async* {
    if (event is OnGastronomiaEventChange) {
      yield GastronomiaLoading();
      try {
        GastronomiaModel serviciosModel = await repository.getGastronomia();
        yield GastronomiaLoaded(serviciosModel);
      } catch (e) {
        yield GastronomiaError('Ocurrio un error');
      }
    }
  }
}
