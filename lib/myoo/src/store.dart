import 'package:myoo/myoo/myoo_api.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Create a Store
Store<AppState> createStore(SharedPreferences prefs) {
  return Store<AppState>(
    appReducer,
    middleware: [
      ...createLocalStorageMiddleware(prefs),
      ...createKyooAPIMiddleware(),
      ...createNavigationMiddleware()
    ],
    initialState: AppState.initState()
  );
}
