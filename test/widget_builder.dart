import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> build(Widget widget, {NavigatorObserver? observer}) async {
  SharedPreferences.setMockInitialValues({});
  return StoreProvider(
    store: createStore(await SharedPreferences.getInstance()),
    child: MaterialApp(
      navigatorObservers: observer != null ? [observer] : [],
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: widget,
        )
      )
    ),
  );
}
