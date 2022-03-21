
import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/views/init_page.dart';
import 'package:myoo/myoo/src/views/list_page.dart';
import 'package:myoo/myoo/src/views/login_page.dart';

Map<String, Widget Function()> routes = {
  '/init': () => const InitializationPage(),
  '/login': () => const LoginPage(),
  '/list': () => const ListPage(),
};

dynamic generateRoutes(RouteSettings settings) =>
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
