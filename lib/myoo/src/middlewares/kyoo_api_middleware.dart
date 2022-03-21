import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/loading_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/previews_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:redux/redux.dart';

/// Returns list of middlewares related to [KyooAPI]
List<Middleware<AppState>> createKyooAPIMiddleware() => [
  TypedMiddleware<AppState, LoadMovieAction>(loadMovie()),
  TypedMiddleware<AppState, LoadSeasonAction>(loadSeason()),
  TypedMiddleware<AppState, LoadTVSeriesAction>(loadTVSeries()),
  TypedMiddleware<AppState, LoadLibraries>(loadLibraries()),
  TypedMiddleware<AppState, LoadPreviewsFromLibrary>(loadItems()),
];

/// Retrieve [Movie] from [AppState]'s current [KyooClient] and dispatches it using [LoadedMovieAction]
Middleware<AppState> loadMovie() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    store.state.currentClient!
      .getMovie((action as ContainerAction<Slug>).content)
      .then((movie) => store.dispatch(LoadedMovieAction(movie)));
  };

/// Retrieve [TVSeries] from [AppState]'s current [KyooClient] and dispatches it using [LoadTVSeriesAction]
Middleware<AppState> loadTVSeries() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    store.state.currentClient!
      .getTVSeries((action as ContainerAction<Slug>).content)
      .then((movie) => store.dispatch(LoadedTVSeriesAction(movie)));
  };

/// Retrieve [Season] from [AppState]'s current [KyooClient] and dispatches it using [LoadSeasonAction]
Middleware<AppState> loadSeason() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Slug seasonSlug = (action as ContainerAction<Slug>).content;
    store.state.currentClient!
      .getSeason(seasonSlug)
      .then((season) => store.dispatch(LoadedSeasonAction(season)));
  };

/// Retrieves [Library]es from currently connected [KyooClient] in [AppState]
Middleware<AppState> loadLibraries() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    (action as ContainerAction<KyooClient?>).content!
      .getLibraries()
      .then((libraries) => store.dispatch(LoadedLibraries(libraries)));
  };

/// Retrieves [ResourcePreview]s from given [Library]
Middleware<AppState> loadItems() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    store.state.currentClient!
      .getItemsFrom(
        library: store.state.currentLibrary,
        afterID: store.state.previews?.last.id)
      .then((items) {
        store.dispatch(LoadedPreviewsAction(items));
        store.dispatch(LoadedAction());
      });
  };
