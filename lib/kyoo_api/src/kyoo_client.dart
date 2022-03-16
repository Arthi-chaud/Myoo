import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'dart:convert';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:http/http.dart' as http;
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

part 'kyoo_client.g.dart';

typedef ServerURL = String;

enum RequestType { get, post, put, delete }

/// Client of a Kyoo Server, used to make requests to it
@JsonSerializable()
class KyooClient {
  /// String URL of the Kyoo server
  @JsonKey(name: 'url')
  final ServerURL serverURL;

  /// JWT used to make requests to server
  @JsonKey(defaultValue: null)
  String? jwt;

  /// Default constructor
  KyooClient({required this.serverURL, this.jwt});

  factory KyooClient.fromJson(JSONData input) => _$KyooClientFromJson(input);

  JSONData toJson() => _$KyooClientToJson(this);

  /// Retrieves a list of $[count] [RessourcePreview]s, starting from [afterID] from the current server
  Future<List<RessourcePreview>> getItems({int? afterID, int? count}) async {
    Map<String, dynamic> queryParams = {};
    if (afterID != null) {
      queryParams['afterID'] = afterID;
    }
    if (count != null) {
      queryParams['count'] = count;
    }
    JSONData responseBody =
        await _request(RequestType.get, '/items', params: queryParams);
    return (responseBody['items'] as List<JSONData>)
        .map((e) => RessourcePreview.fromJson(e))
        .toList();
  }

  /// Retrieves a [Movie] (with its [Genre]s) from current server using its [Slug]
  Future<Movie> getMovie(Slug movieSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/shows/$movieSlug',
        params: {'fields': 'genres'});
    return Movie.fromJson(responseBody);
  }

  /// Retrieves a [TVSeries] (with its [Genre]s and [Season]s) from current server using [TVSeries]'s [Slug]
  Future<TVSeries> getSeries(Slug seriesSlug) async {
    JSONData responseBody = await _request(
        RequestType.get, '/shows/$seriesSlug',
        params: {'fields': 'genres,seasons'});
    return TVSeries.fromJson(responseBody);
  }

  /// Retrieves [Episode]s of a [Season] from current server using [Season]'s [Slug]
  Future<List<Episode>> getEpisodes(Slug seasonSlug) async {
    JSONData responseBody = await _request(
        RequestType.get, '/seasons/$seasonSlug/episodes',
        params: {'limit': '0'});
    return (responseBody['items'] as List)
        .map((item) => Episode.fromJson(item))
        .toList();
  }

  /// Retrieves a [Collection] (including its [RessourcePreview]s ) using its [Slug]
  Future<Collection> getCollection(Slug collectionSlug) async {
    JSONData responseBody = await _request(
        RequestType.get, '/collections/$collectionSlug',
        params: {'fields': 'shows'});
    return Collection.fromJson(responseBody);
  }

  /// Retrieves the server's [Librarie]s
  Future<List<Library>> getLibraries() async {
    JSONData responseBody = await _request(RequestType.get, '/libraries');
    return (responseBody['items'] as List)
        .map((e) => Library.fromJson(e))
        .toList();
  }

  /// Request Kyoo's API, the route must not start with '/api'
  Future<JSONData> _request(RequestType type, String route,
      {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    body ??= {};
    params ??= {};
    http.Response response;
    Uri fullRoute =
        Uri(host: serverURL, path: 'api$route', queryParameters: params);
    final Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (jwt != null) {
      body['Authorization'] = 'Bearer $jwt';
    }
    switch (type) {
      case RequestType.get:
        response = await http.get(fullRoute);
        break;
      case RequestType.post:
        response = await http.post(fullRoute, body: body, headers: headers);
        break;
      case RequestType.put:
        response = await http.put(fullRoute, body: body, headers: headers);
        break;
      case RequestType.delete:
        response = await http.delete(fullRoute, body: body, headers: headers);
        break;
    }
    return jsonDecode(response.body);
  }
}
