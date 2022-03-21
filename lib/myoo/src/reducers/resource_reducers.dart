import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/previews_actions.dart';
import 'package:redux/redux.dart';

final currentMovieReducers = combineReducers<Movie?>([
  TypedReducer<Movie?, LoadedMovieAction>(setResource<Movie>),
  TypedReducer<Movie?, UnloadMovieAction>(unsetResource<Movie>)
]);

final currentTVSeriesReducers = combineReducers<TVSeries?>([
  TypedReducer<TVSeries?, LoadedMovieAction>(setResource<TVSeries>),
  TypedReducer<TVSeries?, UnloadMovieAction>(unsetResource<TVSeries>)
]);

final currentSeasonReducers = combineReducers<Season?>([
  TypedReducer<Season?, LoadedMovieAction>(setResource<Season>),
  TypedReducer<Season?, UnloadMovieAction>(unsetResource<Season>)
]);

final previewsReducers = combineReducers<List<ResourcePreview>?>([
  TypedReducer<List<ResourcePreview>?, LoadedPreviewsAction>(setResource<List<ResourcePreview>>),
  TypedReducer<List<ResourcePreview>?, UnloadPreviewsAction>(unsetResource<List<ResourcePreview>>)
]);

T setResource<T>(T? oldValue, action) => (action as ContainerAction<T>).content;
T? unsetResource<T>(T? oldValue, action) => null;
