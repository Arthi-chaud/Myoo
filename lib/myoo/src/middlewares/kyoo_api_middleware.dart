import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:redux/redux.dart';

/// Returns list of middlewares related to [KyooAPI]
List<Middleware<AppState>> createKyooAPIMiddleware() => [
  TypedMiddleware<AppState, LoadMovieAction>(loadMovie()),
  TypedMiddleware<AppState, LoadSeasonAction>(loadSeason()),
  TypedMiddleware<AppState, LoadTVSeriesAction>(loadTVSeries()),
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
      .then(
        (season) => store.dispatch(
          LoadedSeasonAction(season)
        )
      );
  };
