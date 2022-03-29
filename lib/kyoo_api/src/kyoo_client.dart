import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'dart:convert';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:http/http.dart' as http;
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

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

  /// Default constructor
  KyooClient({required this.serverURL, this.jwt, this.serverLibraries = const []});

  factory KyooClient.fromJson(JSONData input) => _$KyooClientFromJson(input);

  JSONData toJson() => _$KyooClientToJson(this);

  /// Retrieves full download link for resource, using client's [serverURL]
  String getDownloadLink(Resource resource) => Uri.http(serverURL, 'video/${resource.slug}').toString();

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

  /// Retrieves a [Movie] (with its [Genre]s) from current server using its [Slug]
  Future<Movie> getMovie(Slug movieSlug) async {
    JSONData responseBody = await _request(
      RequestType.get, '/shows/$movieSlug',
      params: {'fields': 'genres,studio'});
    return Movie.fromJson(responseBody);
  }

  /// Retrieves a [TVSeries] (with its [Genre]s and [Season]s) from current server using [TVSeries]'s [Slug]
  Future<TVSeries> getTVSeries(Slug seriesSlug) async {
    JSONData responseBody = await _request(
      RequestType.get, '/shows/$seriesSlug',
      params: {'fields': 'genres,seasons,studio'});
    return TVSeries.fromJson(responseBody);
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
  Future<JSONData> _request(RequestType type, String route, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    body ??= {};
    params ?? {};
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
