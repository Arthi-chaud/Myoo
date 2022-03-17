import 'package:myoo/myoo/src/app_state.dart';

AppState appReducer(AppState oldState, action) => AppState(
    isLoading: isLoading,
    clients: clients,
    currentClient: currentClient,
    previews: previews,
    currentMovie: currentMovie,
    currentSeries: currentSeries,
    currentSeason: currentSeason);
