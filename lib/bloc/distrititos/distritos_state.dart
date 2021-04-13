part of 'distritos_bloc.dart';

@immutable
abstract class DistritosState {}

class DistritosInitial extends DistritosState {}

class DistritosLoading extends DistritosState {}

class DistritosLoaded extends DistritosState {
  final CiudadesModel ciudadesModel;

  DistritosLoaded(this.ciudadesModel);
}

class DistritosError extends DistritosState {
  final String error;

  DistritosError(this.error);
}