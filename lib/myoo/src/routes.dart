
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/views/init_page.dart';

Map<String, Widget Function()> routes = {
  '/init': () => const InitializationPage(),
};

dynamic generateRoutes (RouteSettings settings) =>
  PageRouteBuilder(
    opaque: false,
    settings: settings,
    pageBuilder: (_, __, ___) => routes[settings.name]!.call(),
    transitionDuration: const Duration(milliseconds: 350),
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
