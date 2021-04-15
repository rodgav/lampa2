part of 'atractivo_bloc.dart';

@immutable
abstract class AtractivoEvent {}

class OnReciveAtractivo extends AtractivoEvent {
  final Atractivos atractivos;

  OnReciveAtractivo(this.atractivos);
}
