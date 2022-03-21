import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 13, 19, 35);

const ColorScheme colorScheme = ColorScheme(
  primary: primaryColor,
  secondary: Color.fromARGB(255, 226, 60, 0),
  background: primaryColor,
  brightness: Brightness.dark,
  onError: Colors.red,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: Colors.white,
  surface: Color.fromARGB(255, 0x33, 0x33, 0x33),
  onSurface: Color.fromARGB(255, 113, 113, 113),
);

/// Retrieves color scheme from current context
ColorScheme getColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;
