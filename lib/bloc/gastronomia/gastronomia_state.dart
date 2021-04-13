part of 'gastronomia_bloc.dart';

@immutable
abstract class GastronomiaState {}

class GastronomiaInitial extends GastronomiaState {}
class GastronomiaLoading extends GastronomiaState {}

class GastronomiaLoaded extends GastronomiaState {
  final GastronomiaModel gastronomiaModel;

  GastronomiaLoaded(this.gastronomiaModel);
}

class GastronomiaError extends GastronomiaState {
  final String error;

  GastronomiaError(this.error);
}