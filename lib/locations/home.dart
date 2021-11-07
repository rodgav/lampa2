import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:lampa2/bloc/pages/pages_bloc.dart';
import 'package:lampa2/pages/home.dart';
import 'package:lampa2/pages/notFound.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLocation extends BeamLocation {

  @override
  List<String> get pathBlueprints => ['/home/:name'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    final name = state.pathParameters['name'] ?? '';
    context.read<PagesBloc>().cambiarPageSubPage(name);
    return [
      BeamPage(
        key: ValueKey('home'),
        child: HomePage(),
      ),
      /*if (state.uri.pathSegments.contains('books'))
      BeamPage(
        key: ValueKey('books'),
        child: BooksScreen(),
      ),
    if (state.pathParameters.containsKey('bookId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['bookId']}'),
        child: BookDetailsScreen(
          bookId: state.pathParameters['bookId'],
        ),
      ),*/
    ];
  }

  final forbiddenPage = BeamPage(
    child: NotFoundPage(),
  );

  @override
  List<BeamGuard> get guards => [
        BeamGuard(
          pathBlueprints: ['/home/*'],
          check: (context, location) =>
              location.state.pathParameters['name'] == 'ciudad' ||
              location.state.pathParameters['name'] == 'mapa' ||
              location.state.pathParameters['name'] == 'camara',
          showPage: forbiddenPage,
        ),
      ];
}
