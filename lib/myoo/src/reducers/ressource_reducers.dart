
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/previews_actions.dart';
import 'package:redux/redux.dart';

final currentMovieReducers = combineReducers<Movie?>([
  TypedReducer<Movie?, LoadedMovieAction>(setRessource<Movie>),
  TypedReducer<Movie?, UnloadMovieAction>(unsetRessource<Movie>)
]);

final currentTVSeriesReducers = combineReducers<TVSeries?>([
  TypedReducer<TVSeries?, LoadedMovieAction>(setRessource<TVSeries>),
  TypedReducer<TVSeries?, UnloadMovieAction>(unsetRessource<TVSeries>)
]);

final currentSeasonReducers = combineReducers<Season?>([
  TypedReducer<Season?, LoadedMovieAction>(setRessource<Season>),
  TypedReducer<Season?, UnloadMovieAction>(unsetRessource<Season>)
]);

final previewsReducers = combineReducers<List<RessourcePreview>?>([
  TypedReducer<List<RessourcePreview>?, LoadedPreviewsAction>(setRessource<List<RessourcePreview>>),
  TypedReducer<List<RessourcePreview>?, UnloadPreviewsAction>(unsetRessource<List<RessourcePreview>>)
]);

T setRessource<T>(T? oldValue, action) => (action as ContainerAction<T>).content;
T? unsetRessource<T>(T? oldValue, action) => null;
