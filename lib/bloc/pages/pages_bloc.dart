import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'pages_event.dart';

part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {
  PagesBloc() : super(PagesState());

  void cambiarPageSubPage(String page) {
    add(OnPageSubPageCambio(page));
  }

  @override
  Stream<PagesState> mapEventToState(
    PagesEvent event,
  ) async* {
    if (event is OnPageSubPageCambio) {
      yield state.copyWhit(
        page: event.page,
      );
    }
  }
}
