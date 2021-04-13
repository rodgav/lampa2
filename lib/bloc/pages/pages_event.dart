part of 'pages_bloc.dart';

@immutable
abstract class PagesEvent {}

class OnPageSubPageCambio extends PagesEvent {
  final String page;

  OnPageSubPageCambio(this.page);
}
