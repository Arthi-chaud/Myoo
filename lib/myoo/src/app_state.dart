import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/kyoo_api/src/models/watch_item.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:myoo/myoo/src/models/search_result.dart';
import 'package:myoo/myoo/src/models/streaming_parameters.dart';

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

  /// Current [WatchItem] that is being played
  final WatchItem? currentVideo;

  /// Loading state
  final bool isLoading;

  /// The parameters of the current stream
  final StreamingParameters? streamingParams;
  /// The result of the current search
  final SearchResult? searchResult;

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
    required this.streamingParams,
    required this.searchResult,
    required this.currentSeason}) {
    assert(
      (clients != null && currentClient != null && clients!.isEmpty) ||
      (clients?.map((client) => client.serverURL).toList().contains(currentClient?.serverURL) ?? true),
      'The current client is not known'
    );
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
    streamingParams = null,
    searchResult = null,
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
    WatchItem? currentVideo,
    StreamingParameters? streamingParams,
    SearchResult? searchResult,
    bool? isLoading,
  }) => AppState(
    currentClient: currentClient ?? this.currentClient,
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
    streamingParams: streamingParams ?? this.streamingParams,
    currentLibrary: currentLibrary ?? this.currentLibrary,
    currentMovie: currentMovie ?? this.currentMovie,
    currentTVSeries: currentTVSeries ?? this.currentTVSeries,
    currentSeason: currentSeason ?? this.currentSeason,
    currentVideo: currentVideo ?? this.currentVideo,
    searchResult: searchResult ?? this.searchResult,
    currentCollection: currentCollection ?? this.currentCollection
  );

  @override
  int get hashCode =>
    clients.hashCode ^
    streamingParams.hashCode ^
    currentClient.hashCode ^
    isLoading.hashCode ^
    currentLibrary.hashCode ^
    currentClient.hashCode ^
    currentMovie.hashCode ^
    currentTVSeries.hashCode ^
    currentCollection.hashCode ^
    currentVideo.hashCode ^
    searchResult.hashCode ^
    currentSeason.hashCode;

  @override
  bool operator ==(Object other) =>
    other is AppState &&
    streamingParams == other.streamingParams &&
    clients == other.clients &&
    currentClient == other.currentClient &&
    isLoading == other.isLoading &&
    currentLibrary == other.currentLibrary &&
    currentClient == other.currentClient &&
    currentMovie == other.currentMovie &&
    currentVideo == other.currentVideo &&
    searchResult == other.searchResult &&
    currentTVSeries == other.currentTVSeries &&
    currentCollection == other.currentCollection &&
    currentSeason == other.currentSeason;
}
