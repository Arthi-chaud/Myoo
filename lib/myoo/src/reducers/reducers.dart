import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/reducers/loading_reducers.dart';

AppState appReducer(AppState oldState, action) => AppState(
    isLoading: loadingReducers(oldState.isLoading, action),
    clients: clients,
    currentClient: currentClient,
    previews: previews,
    currentMovie: currentMovie,
    currentTVSeries: currentSeries,
    currentSeason: currentSeason);
