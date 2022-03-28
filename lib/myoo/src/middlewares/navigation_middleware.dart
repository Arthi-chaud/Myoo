import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/navigation.dart';
import 'package:redux/redux.dart';

/// Returns list of middlewares related to navigation
List<Middleware<AppState>> createNavigationMiddleware() => [
  TypedMiddleware<AppState, NavigatorPushAction>(push()),
  TypedMiddleware<AppState, NavigatorPopAction>(pop()),
  TypedMiddleware<AppState, NavigatorPopAndPushAction>(popAndPush()),
];

/// Push named route, and calls push function from given action
/// On pop, will call the pop callback
Middleware<AppState> push() =>
  (Store<AppState> store, action, NextDispatcher next) {
    NavigationActionContent actionContent = (action as ContainerAction<NavigationActionContent>).content;
    navigatorKey.currentState?.pushNamed(actionContent.routeName)
      .then((_) => actionContent.onPop?.call());
    next(action);
  };

Middleware<AppState> pop() =>
  (Store<AppState> store, action, NextDispatcher next) {
    navigatorKey.currentState?.pop();
    next(action);
  };

Middleware<AppState> popAndPush() =>
  (Store<AppState> store, action, NextDispatcher next) {
    navigatorKey.currentState?.pop();
    NavigationActionContent actionContent = (action as ContainerAction<NavigationActionContent>).content;
    navigatorKey.currentState?.pushNamed(actionContent.routeName)
      .then((_) => actionContent.onPop?.call());
    next(action);
  };
