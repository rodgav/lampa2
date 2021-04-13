import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lampa2/bloc/repository.dart';
import 'package:lampa2/models/atractivos.dart';
import 'package:meta/meta.dart';

part 'atractivos_event.dart';
part 'atractivos_state.dart';

class AtractivosBloc extends Bloc<AtractivosEvent, AtractivosState> {
  AtractivosBloc({@required this.repository}) : super(AtractivosInitial());
  final Repository repository;
  @override
  Stream<AtractivosState> mapEventToState(
    AtractivosEvent event,
  ) async* {
    if (event is OnAtractivosEventChange) {
      yield AtractivosLoading();
      try {
        AtractivosModel serviciosModel = await repository.getAtractivos();
        yield AtractivosLoaded(serviciosModel);
      } catch (e) {
        yield AtractivosError('Ocurrio un error');
      }
    }
  }
}
