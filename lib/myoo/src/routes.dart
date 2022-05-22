import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/views/detail_views/collection_page.dart';
import 'package:myoo/myoo/src/views/init_page.dart';
import 'package:myoo/myoo/src/views/list_page.dart';
import 'package:myoo/myoo/src/views/detail_views/movie_page.dart';
import 'package:myoo/myoo/src/views/detail_views/tvseries_page.dart';
import 'package:myoo/myoo/src/views/play_page.dart';
import 'package:myoo/myoo/src/views/search_page.dart';

/// Routes with names that must match completely to createRoute
Map<String, Widget Function()> routes = {
  '/init': () => const InitializationPage(),
  '/list': () => const ListPage(),
  '/collection': () => const CollectionPage(),
  '/movie': () => const MoviePage(),
  '/series': () => const TVSeriesPage(),
  '/search': () => const SearchPage(),
};

/// Map of routes that might be followed by a parameter
Map<String, Widget Function()> parameteredRoutes = {
  '/play': () => const PlayPage(),
};

const transitionDuration = Duration(milliseconds: 350);

dynamic generateRoutes(RouteSettings settings) =>
  PageRouteBuilder(
    opaque: false,
    settings: settings,
    pageBuilder: (_, __, ___) {
      if (routes.keys.contains(settings.name)) {
        return routes[settings.name]!.call();
      }
      return parameteredRoutes[parameteredRoutes.keys.firstWhere((route) => settings.name!.startsWith(route))]!.call();
    },
    transitionDuration: transitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      SlideTransition(
        child: child,
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero
          )
        )
      )
  );
