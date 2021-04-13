part of 'atractivos_bloc.dart';

@immutable
abstract class AtractivosState {}

class AtractivosInitial extends AtractivosState {}

class AtractivosLoading extends AtractivosState {}

class AtractivosLoaded extends AtractivosState {
  final AtractivosModel atractivosModel;

  AtractivosLoaded(this.atractivosModel);
}

class AtractivosError extends AtractivosState {
  final String error;

  AtractivosError(this.error);
}
