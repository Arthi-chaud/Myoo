import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
/// State of the Myoo App
class AppState {
  /// List of clients in the current state
  final List<KyooClient>? clients;
  /// The current [KyooClient] from which the requests must be made with
  final KyooClient? currentClient;
  /// Array of [ressourcePreview], for example in list view
  final List<RessourcePreview>? previews;
  /// Current [TVSeries], it must hold related [Season]s
  final TVSeries? currentTVSeries;
  /// Current [Season], it must hold related [Episode]s
  final Season? currentSeason;
  /// Current [Movie]
  final Movie? currentMovie;
  /// Loading state
  final bool isLoading;

  /// Default constructor
  AppState({
    required this.isLoading,
    required this.clients,
    required this.currentClient,
    required this.previews,
    required this.currentMovie,
    required this.currentTVSeries,
    required this.currentSeason
  }) {
    assert(clients?.contains(currentClient!) ?? true, 'The current client is not known');
  }
  /// Initial state for [MyooApp], sets [isLoading] to true.
  /// The first thing done when initiating the [MyooApp] is to load [KyooClient]s
  AppState.initState():
    isLoading = true,
    currentClient = null,
    clients = null,
    previews = null,
    currentMovie = null,
    currentTVSeries = null,
    currentSeason = null;

  /// Copy constructor for easier copies
  AppState copyWith({
    List<KyooClient>? clients,
    KyooClient? currentClient,
    List<RessourcePreview>? previews,
    TVSeries? currentTVSeries,
    Season? currentSeason,
    Movie? currentMovie,
    bool? isLoading,
  }) => AppState(
    currentClient: currentClient ?? this.currentClient,
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
    previews: previews ?? this.previews,
    currentMovie: currentMovie ?? this.currentMovie,
    currentTVSeries: currentTVSeries ?? this.currentTVSeries,
    currentSeason: currentSeason ?? this.currentSeason
  );

  @override
  int get hashCode => clients.hashCode ^
    currentClient.hashCode ^ 
    isLoading.hashCode ^
    previews.hashCode ^
    currentClient.hashCode ^
    currentMovie.hashCode ^
    currentTVSeries.hashCode ^
    currentSeason.hashCode;
  
  @override
  bool operator==(Object other) =>
    other is AppState &&
    clients == other.clients &&
    currentClient == other.currentClient &&
    isLoading == other.isLoading &&
    previews == other.previews &&
    currentClient == other.currentClient &&
    currentMovie == other.currentMovie &&
    currentTVSeries == other.currentTVSeries &&
    currentSeason == other.currentSeason;

}
