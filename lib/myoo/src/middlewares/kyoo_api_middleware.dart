import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/collection_actions.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/actions/movie_actions.dart';
import 'package:myoo/myoo/src/actions/season_actions.dart';
import 'package:myoo/myoo/src/actions/tv_series_actions.dart';
import 'package:myoo/myoo/src/actions/video_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:redux/redux.dart';

/// Returns list of middlewares related to [KyooAPI]
List<Middleware<AppState>> createKyooAPIMiddleware() => [
  TypedMiddleware<AppState, LoadVideoAction>(loadVideo()),
  TypedMiddleware<AppState, LoadMovieAction>(loadMovie()),
  TypedMiddleware<AppState, LoadSeasonAction>(loadSeason()),
  TypedMiddleware<AppState, LoadTVSeriesAction>(loadTVSeries()),
  TypedMiddleware<AppState, LoadCollectionAction>(loadCollection()),
  TypedMiddleware<AppState, LoadLibraries>(loadLibraries()),
  TypedMiddleware<AppState, LoadContentFromLibrary>(loadItems()),
  TypedMiddleware<AppState, UseClientAction>(loadItems()),
  TypedMiddleware<AppState, UseClientAction>(loadLibraries()),
  TypedMiddleware<AppState, NewClientConnectedAction>(loadItems()),
  TypedMiddleware<AppState, NewClientConnectedAction>(loadLibraries()),
];

/// Retrieve [WatchItem] from [AppState]'s current [KyooClient] and dispatches it using [LoadedVideoAction]
Middleware<AppState> loadVideo() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    store.state.currentClient!
      .getWatchItem((action as ContainerAction<Slug>).content)
      .then((item) => store.dispatch(LoadedVideoAction(item)));
  };

/// Retrieve [Movie] from [AppState]'s current [KyooClient] and dispatches it using [LoadedMovieAction]
Middleware<AppState> loadMovie() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    store.state.currentClient!
      .getMovie((action as ContainerAction<Slug>).content)
      .then((movie) => store.dispatch(LoadedMovieAction(movie)));
  };

/// Retrieve [TVSeries] from [AppState]'s current [KyooClient] and dispatches it using [LoadedTVSeriesAction]
Middleware<AppState> loadTVSeries() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    store.state.currentClient!
      .getTVSeries((action as ContainerAction<Slug>).content)
      .then((series) => store.dispatch(LoadedTVSeriesAction(series)));
  };

/// Retrieve [Season] from [AppState]'s current [KyooClient] and dispatches it using [LoadedSeasonAction]
Middleware<AppState> loadSeason() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Slug seasonSlug = (action as ContainerAction<Slug>).content;
    store.state.currentClient!
      .getSeason(seasonSlug)
      .then((season) => store.dispatch(LoadedSeasonAction(season)));
  };

/// Retrieve [Collection] from [AppState]'s current [KyooClient] and dispatches it using [LoadedCollectionAction]
Middleware<AppState> loadCollection() =>
  (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    Slug collectionSlug = (action as ContainerAction<Slug>).content;
    store.state.currentClient!
      .getCollection(collectionSlug)
      .then((collection) => store.dispatch(LoadedCollectionAction(collection)));
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
    LibraryContent currentLibrary = store.state.currentLibrary!;
    const int itemCount = 30;
    store.state.currentClient!
      .getItemsFrom(
        library: currentLibrary.library,
        afterID: currentLibrary.content.isEmpty ? null : currentLibrary.content.last.id,
        count: itemCount
      )
      .then((items) {
        if (items.length < itemCount) {
          store.dispatch(LibraryIsFullAction());
        }
        store.dispatch(LoadedContentFromLibraryAction(items));
      });
  };
