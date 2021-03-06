import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'dart:convert';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:http/http.dart' as http;
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/kyoo_api/src/models/staff.dart';
import 'package:myoo/kyoo_api/src/models/watch_item.dart';

part 'kyoo_client.g.dart';

typedef ServerURL = String;

enum RequestType { get, post, put, delete }

/// Interface of a Kyoo Server, used to make requests to it
@JsonSerializable()
class KyooClient {
  /// String URL of the Kyoo server
  @JsonKey(name: 'url')
  final ServerURL serverURL;

  /// JWT used to make requests to server
  @JsonKey(defaultValue: null)
  String? jwt;

  /// The server's Libraries
  @JsonKey(ignore: true)
  List<Library> serverLibraries;

  /// HTTP Client interface to manage requests
  /// If none provided, a default instance will be used
  @JsonKey(ignore: true)
  http.Client client;

  /// Default constructor
  KyooClient({
    required this.serverURL,
    this.jwt,
    this.serverLibraries = const [],
    http.Client? client
  }) : client = client ?? http.Client();

  factory KyooClient.fromJson(JSONData input) => _$KyooClientFromJson(input);

  JSONData toJson() => _$KyooClientToJson(this);

  /// Retrieves full download link for [Video], using client's [serverURL]
  /// The slug must be from a [Video]
  String getVideoDownloadLink(Slug videoSlug) => Uri.http(serverURL, 'video/$videoSlug').toString();

  /// Retrieves full download link for subtitle [Track], using client's [serverURL]
  /// The slug must be from a subtitle [Track]
  String getSubtitleTrackDownloadLink(Slug subSlug, String codec) {
    if (codec == 'subrip') {
      codec = 'srt';
    }
    return Uri.http(serverURL, 'subtitles/$subSlug.$codec').toString();
  }
  
  /// Retrieves streaming link for resource, using client's [serverURL] and a [StreamingMethod]
  /// The slug must be from a [Video]
  String getStreamingLink(Slug videoSlug, StreamingMethod method) {
    String path;
    switch (method) {
      case StreamingMethod.direct:
        path = '/videos/direct/$videoSlug';
        break;
      case StreamingMethod.transmux:
        path = '/videos/transmux/$videoSlug/master.m3u8';
        break;
    }
    return Uri.http(serverURL, path).toString();
  }

  /// Retrieves the extension of the source file stored on the server
  Future<String> getFileExtension(Slug resourceSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/watch/$resourceSlug');
    return responseBody['container'] as String;
  } 

  /// Retrieves a list of $[count] [ResourcePreview]s, starting from [afterID] from the current server
  /// If library is [null], fetches items from '/api/items', otherwise, fetch items from given collection
  Future<List<ResourcePreview>> getItemsFrom({Library? library, int? afterID, int? count}) async {
    Map<String, dynamic> queryParams = {};
    final String route = library == null ? '/items' : '/libraries/${library.slug}/items';
    if (afterID != null) {
      queryParams['afterID'] = afterID.toString();
    }
    if (count != null) {
      queryParams['limit'] = count.toString();
    }
    JSONData responseBody = await _request(RequestType.get, route, params: queryParams);
    return (responseBody['items'] as List)
      .map((e) => ResourcePreview.fromJson(e as JSONData))
      .toList();
  }

  Future<Staff> getStaff (Slug slug) async {
    JSONData responseBody = await _request(
      RequestType.get, '/show/$slug/staff', params: {'limit': '0'});
    return (responseBody['items'] as List)
      .map((e) => StaffMember.fromJson(e as JSONData))
      .toList();
  }

  /// Retrieves a [Movie] (with its [Genre]s) from current server using its [Slug]
  Future<Movie> getMovie(Slug movieSlug) async {
    JSONData responseBody = await _request(
      RequestType.get, '/shows/$movieSlug',
      params: {'fields': 'genres,studio,externalIDs'});
    return Movie.fromJson(responseBody)..staff = await getStaff(movieSlug);
  }

  /// Retrieves a [TVSeries] (with its [Genre]s and [Season]s) from current server using [TVSeries]'s [Slug]
  Future<TVSeries> getTVSeries(Slug seriesSlug) async {
    JSONData responseBody = await _request(
      RequestType.get, '/shows/$seriesSlug',
      params: {'fields': 'genres,seasons,studio,externalIDs'});
    return TVSeries.fromJson(responseBody)..staff = await getStaff(seriesSlug);
  }

  /// Retrieves a [Season] with its [Episode]s from current server using [Season]'s [Slug]
  Future<Season> getSeason(Slug seasonSlug) async {
    JSONData responseBody = await _request(
      RequestType.get, '/seasons/$seasonSlug',
      params: {'limit': '0', 'fields': 'episodes'});
    return Season.fromJson(responseBody);
  }

  /// Retrieves a [Collection] (including its [ResourcePreview]s ) using its [Slug]
  Future<Collection> getCollection(Slug collectionSlug) async {
    JSONData collection = await _request(
      RequestType.get, '/collections/$collectionSlug');
    JSONData collectionContent = await _request(RequestType.get, '/collections/$collectionSlug/shows',
      params: {'sortBy': 'startair'});
    return Collection.fromJson(collection)
      ..content = (collectionContent['items'] as List).map(
        (e) => ResourcePreview.fromJson(e)
      ).toList();
  }

  /// Elevates a [Video] to a [WatchItem] using its [Slug]
  Future<WatchItem> getWatchItem(Slug videoSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/watch/$videoSlug');
    return WatchItem.fromJson(responseBody);
  }

  /// Retrieves the server's [Librarie]s
  Future<List<Library>> getLibraries() async {
    JSONData responseBody = await _request(RequestType.get, '/libraries');
    return (responseBody['items'] as List)
      .map((e) => Library.fromJson(e))
      .toList();
  }

  Future<Map<String, List>> searchItems(String query) async {
    JSONData responseBody = await _request(RequestType.get, '/search/$query');
    List<ResourcePreview> shows = (responseBody['shows'] as List)
      .map((e) => ResourcePreview.fromJson(e))
      .toList();
    return {
      'movies': shows.where((element) => element.type == ResourcePreviewType.movie).toList(),
      'tvSeries': shows.where((element) => element.type == ResourcePreviewType.series).toList(),
      'collections': (responseBody['collections'] as List)
        .map((e) => IllustratedResource.fromJson(e))
        .toList(),
      'episodes': (responseBody['episodes'] as List)
        .map((e) => Episode.fromJson(e))
        .toList(),
      'staff': (responseBody['people'] as List)
        .map((e) => StaffMember.fromJson(e))
        .toList()
    };
  }
  /// Request Kyoo's API, the route must not start with '/api'
  /// Uses [client]
  Future<JSONData> _request(RequestType type, String route, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    body ??= {};
    params ?? {}; ///TODO ??
    http.Response response;
    Uri fullRoute = Uri.http(serverURL, 'api$route', params);
    final Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (jwt != null) {
      body['Authorization'] = 'Bearer $jwt';
    }
    switch (type) {
      case RequestType.get:
        response = await client.get(fullRoute);
        break;
      case RequestType.post:
        response = await client.post(fullRoute, body: body, headers: headers);
        break;
      case RequestType.put:
        response = await client.put(fullRoute, body: body, headers: headers);
        break;
      case RequestType.delete:
        response = await client.delete(fullRoute, body: body, headers: headers);
        break;
    }
    return jsonDecode(response.body);
  }

  @override
  int get hashCode => serverURL.hashCode;
  @override
  bool operator ==(Object other) => identical(this, other) || other is KyooClient && serverURL == other.serverURL;
}
