import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/reducers/clients_reducers.dart';
import 'package:myoo/myoo/src/reducers/library_reducers.dart';
import 'package:myoo/myoo/src/reducers/loading_reducers.dart';
import 'package:myoo/myoo/src/reducers/resource_reducers.dart';
import 'package:myoo/myoo/src/reducers/search_reducers.dart';
import 'package:myoo/myoo/src/reducers/streaming_reducers.dart';

AppState appReducer(AppState oldState, action) => AppState(
  isLoading: loadingReducers(oldState.isLoading, action),
  clients: clientsReducers(oldState.clients, action),
  currentClient: currentClientReducers(oldState.currentClient, action),
  currentLibrary: currentLibraryReducers(oldState.currentLibrary, action),
  currentMovie: currentMovieReducers(oldState.currentMovie, action),
  currentTVSeries: currentTVSeriesReducers(oldState.currentTVSeries, action),
  currentCollection: currentCollectionReducers(oldState.currentCollection, action),
  currentSeason: currentSeasonReducers(oldState.currentSeason, action),
  currentVideo: currentVideoReducers(oldState.currentVideo, action),
  streamingParams: streamingReducers(oldState.streamingParams, action),
  searchResult: searchReducers(oldState.searchResult, action),
);
