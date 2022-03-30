import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/myoo/src/models/library_content.dart';

/// State of the Myoo App
class AppState {
  /// List of clients in the current state
  final List<KyooClient>? clients;

  /// The current [KyooClient] from which the requests must be made with
  final KyooClient? currentClient;

  /// The current [Library] whose items are listed
  final LibraryContent? currentLibrary;

  /// Current [TVSeries], it must hold related [Season]s
  final TVSeries? currentTVSeries;

  /// Current [Collection], it must hold related [ResourcePreview]s
  final Collection? currentCollection;

  /// Current [Season], it must hold related [Episode]s
  final Season? currentSeason;

  /// Current [Movie]
  final Movie? currentMovie;

  /// Current [Video] that is being played
  final Video? currentVideo;

  /// Loading state
  final bool isLoading;

  /// Default constructor
  AppState({
    required this.isLoading,
    required this.clients,
    required this.currentClient,
    required this.currentMovie,
    required this.currentLibrary,
    required this.currentVideo,
    required this.currentTVSeries,
    required this.currentCollection,
    required this.currentSeason}) {
    assert(clients?.map((client) => client.serverURL).toList().contains(currentClient!.serverURL) ?? true, 'The current client is not known');
  }

  /// Initial state for [MyooApp], sets [isLoading] to true.
  /// The first thing done when initiating the [MyooApp] is to load [KyooClient]s
  AppState.initState():
    isLoading = true,
    currentClient = null,
    clients = null,
    currentLibrary = null,
    currentVideo = null,
    currentMovie = null,
    currentTVSeries = null,
    currentCollection = null,
    currentSeason = null;

  /// Copy constructor for easier copies
  AppState copyWith({
    List<KyooClient>? clients,
    KyooClient? currentClient,
    List<ResourcePreview>? previews,
    LibraryContent? currentLibrary,
    TVSeries? currentTVSeries,
    Season? currentSeason,
    Movie? currentMovie,
    Collection? currentCollection,
    Video? currentVideo,
    bool? isLoading,
  }) => AppState(
    currentClient: currentClient ?? this.currentClient,
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
    currentLibrary: currentLibrary ?? this.currentLibrary,
    currentMovie: currentMovie ?? this.currentMovie,
    currentTVSeries: currentTVSeries ?? this.currentTVSeries,
    currentSeason: currentSeason ?? this.currentSeason,
    currentVideo: currentVideo ?? this.currentVideo,
    currentCollection: currentCollection ?? this.currentCollection
  );

  @override
  int get hashCode =>
    clients.hashCode ^
    currentClient.hashCode ^
    isLoading.hashCode ^
    currentLibrary.hashCode ^
    currentClient.hashCode ^
    currentMovie.hashCode ^
    currentTVSeries.hashCode ^
    currentCollection.hashCode ^
    currentVideo.hashCode ^
    currentSeason.hashCode;

  @override
  bool operator ==(Object other) =>
    other is AppState &&
    clients == other.clients &&
    currentClient == other.currentClient &&
    isLoading == other.isLoading &&
    currentLibrary == other.currentLibrary &&
    currentClient == other.currentClient &&
    currentMovie == other.currentMovie &&
    currentVideo == other.currentVideo &&
    currentTVSeries == other.currentTVSeries &&
    currentCollection == other.currentCollection &&
    currentSeason == other.currentSeason;
}
