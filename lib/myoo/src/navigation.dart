import 'package:flutter/material.dart';

/// Global key to access [Navigator] outisde build context
/// Used primarily for Navigation [Action]s
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
