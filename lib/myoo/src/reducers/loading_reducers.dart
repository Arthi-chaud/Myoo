import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:redux/redux.dart';

/// List of reducers for loading State ([bool]) of [AppState]
final loadingReducers = combineReducers<bool>([
  TypedReducer<bool, LoadedAction>((_, __) => false),
  TypedReducer<bool, LoadAction>((_, __) => true)
]);
