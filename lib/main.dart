import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/navigation.dart';
import 'package:myoo/myoo/src/routes.dart';
import 'package:myoo/myoo/src/store.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  FlutterNativeSplash.remove();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
   statusBarColor: Colors.white,
   statusBarBrightness: Brightness.dark
  ));

  runApp(MyooApp(
    store: createStore(prefs)
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
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Myoo',
        theme: ThemeData(
          colorScheme: colorScheme,
          scaffoldBackgroundColor: colorScheme.primary
        ),
        initialRoute: '/init',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return null;
          }
          return generateRoutes(settings);
        },
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate
        ],
      ),
    );
  }
}
