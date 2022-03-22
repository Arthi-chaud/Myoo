import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:redux/redux.dart';

final currentMovieReducers = combineReducers<Movie?>([
  TypedReducer<Movie?, LoadedMovieAction>(setResource<Movie>),
  TypedReducer<Movie?, UnloadMovieAction>(unsetResource<Movie>)
]);

final currentTVSeriesReducers = combineReducers<TVSeries?>([
  TypedReducer<TVSeries?, LoadedTVSeriesAction>(setResource<TVSeries>),
  TypedReducer<TVSeries?, UnloadTVSeriesAction>(unsetResource<TVSeries>)
]);

final currentSeasonReducers = combineReducers<Season?>([
  TypedReducer<Season?, LoadedSeasonAction>(setResource<Season>),
  TypedReducer<Season?, UnloadSeasonAction>(unsetResource<Season>)
]);

final currentCollectionReducers = combineReducers<Collection?>([
  TypedReducer<Collection?, LoadedCollectionAction>(setResource<Collection>),
  TypedReducer<Collection?, UnloadCollectionAction>(unsetResource<Collection>)
]);

T setResource<T>(T? oldValue, action) => (action as ContainerAction<T>).content;
T? unsetResource<T>(T? oldValue, action) => null;
