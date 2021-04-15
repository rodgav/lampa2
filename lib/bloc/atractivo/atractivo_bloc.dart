import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lampa2/models/atractivos.dart';
import 'package:meta/meta.dart';

part 'atractivo_event.dart';

part 'atractivo_state.dart';

class AtractivoBloc extends Bloc<AtractivoEvent, AtractivoState> {
  AtractivoBloc() : super(AtractivoState());

  @override
  Stream<AtractivoState> mapEventToState(
    AtractivoEvent event,
  ) async* {
    if (event is OnReciveAtractivo) {
      yield AtractivoState(atractivos: event.atractivos);
    }
  }
}
