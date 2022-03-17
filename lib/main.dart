import 'dart:convert';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/reducers/reducers.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyooApp(
    store: Store<AppState>(appReducer,
        initialState: AppState.initState(clients: clients)),
  ));
}

class MyooApp extends StatelessWidget {
  final Store<AppState> store;
  const MyooApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: colorScheme),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
