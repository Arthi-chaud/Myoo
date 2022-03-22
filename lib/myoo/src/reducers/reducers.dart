import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/reducers/clients_reducers.dart';
import 'package:myoo/myoo/src/reducers/library_reducers.dart';
import 'package:myoo/myoo/src/reducers/loading_reducers.dart';
import 'package:myoo/myoo/src/reducers/resource_reducers.dart';

AppState appReducer(AppState oldState, action) => AppState(
    isLoading: loadingReducers(oldState.isLoading, action),
    clients: clientsReducers(oldState.clients, action),
    currentClient: currentClientReducers(oldState.currentClient, action),
    currentLibrary: currentLibraryReducers(oldState.currentLibrary, action),
    currentMovie: currentMovieReducers(oldState.currentMovie, action),
    currentTVSeries: currentTVSeriesReducers(oldState.currentTVSeries, action),
    currentSeason: currentSeasonReducers(oldState.currentSeason, action));
