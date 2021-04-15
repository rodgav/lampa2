part of 'atractivo_bloc.dart';

@immutable
class AtractivoState {
  final Atractivos atractivos;

  AtractivoState({this.atractivos});

  AtractivoState copyWhit({Atractivos atractivos}) =>
      AtractivoState(atractivos: atractivos ?? this.atractivos);
}
