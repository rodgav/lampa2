part of 'ciudades_bloc.dart';

@immutable
abstract class CiudadesState {}

class CiudadesInitial extends CiudadesState {}

class CiudadesLoading extends CiudadesState {}

class CiudadesLoaded extends CiudadesState {
  final CiudadesModel ciudadesModel;

  CiudadesLoaded(this.ciudadesModel);
}

class CiudadesError extends CiudadesState {
  final String error;

  CiudadesError(this.error);
}