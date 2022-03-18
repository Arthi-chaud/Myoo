import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/middlewares/kyoo_api_middleware.dart';
import 'package:myoo/myoo/src/middlewares/local_storage_middleware.dart';
import 'package:myoo/myoo/src/reducers/reducers.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyooApp(
    store: Store<AppState>(
      appReducer,
      middleware: [
        ...createLocalStorageMiddleware(prefs),
        ...createKyooAPIMiddleware()
      ],
      initialState: AppState.initState()
    ),
  ));
}

class MyooApp extends StatelessWidget {
  final Store<AppState> store;
  const MyooApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Myoo',
        theme: ThemeData(colorScheme: colorScheme),
        home: const Text("Hello World"),
      )
    );
  }
}
