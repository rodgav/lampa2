part of 'pages_bloc.dart';

@immutable
class PagesState {
  final String page;

  PagesState({this.page = 'notaria'});

  PagesState copyWhit({String page}) =>
      new PagesState(page: page ?? this.page);
}
