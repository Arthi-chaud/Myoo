import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';

class AppState {
  /// List of clients in the current state
  final List<KyooClient> clients;
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
    required this.previews,
    required this.currentMovie,
    required this.currentSeries,
    required this.currentSeason
  });

  /// Copy constructor for easier copies
  AppState copyWith({
    List<KyooClient>? clients,
    List<RessourcePreview>? previews,
    TVSeries? currentSeries,
    Season? currentSeason,
    Movie? currentMovie,
    bool? isLoading,
  }) => AppState(
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
    previews: previews ?? this.previews,
    currentMovie: currentMovie ?? this.currentMovie,
    currentSeries: currentSeries ?? this.currentSeries,
    currentSeason: currentSeason ?? this.currentSeason
  );
}
