import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
/// State of the Myoo App
class AppState {
  /// List of clients in the current state
  final List<KyooClient> clients;
  /// The current [KyooClient] from which the requests must be made with
  final KyooClient currentClient;
  /// Array of [ressourcePreview], for example in list view
  final List<RessourcePreview>? previews;
  /// Current [TVSeries]
  final TVSeries? currentSeries;
  /// Current [Season]
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
    required this.currentSeries,
    required this.currentSeason
  }) {
    assert(clients.contains(currentClient), 'The current client is not known');
  }

  /// Copy constructor for easier copies
  AppState copyWith({
    List<KyooClient>? clients,
    KyooClient? currentClient,
    List<RessourcePreview>? previews,
    TVSeries? currentSeries,
    Season? currentSeason,
    Movie? currentMovie,
    bool? isLoading,
  }) => AppState(
    currentClient: currentClient ?? this.currentClient,
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
    previews: previews ?? this.previews,
    currentMovie: currentMovie ?? this.currentMovie,
    currentSeries: currentSeries ?? this.currentSeries,
    currentSeason: currentSeason ?? this.currentSeason
  );

  @override
  int get hashCode => clients.hashCode ^
    currentClient.hashCode ^ 
    isLoading.hashCode ^
    previews.hashCode ^
    currentClient.hashCode ^
    currentMovie.hashCode ^
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
    currentSeason == other.currentSeason;

}
