import 'package:myoo/myoo/myoo_api.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Store<AppState>> createTestStore() async {
  SharedPreferences.setMockInitialValues({});
  return Store<AppState>(
    appReducer,
    middleware: [
      ...createLocalStorageMiddleware(await SharedPreferences.getInstance()),
      ...createKyooAPIMiddleware(),
      ...createNavigationMiddleware()
    ],
    initialState: AppState.initState()
  );
}
