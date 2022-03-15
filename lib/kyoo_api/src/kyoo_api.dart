import 'dart:convert';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:http/http.dart' as http;
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';

enum RequestType { get, post, put, delete }

/// Interface Class to communicate
class KyooAPI {
  /// URL to the Server to call when using member function of this instance of [KyooAPI]
  final String serverURL;

  // TODO: manage JWT

  /// Construct a [KyooAPI] using Server's URL
  KyooAPI({required this.serverURL});

  /// Retrieves a list of $[count] [RessourcePreview]s, starting from [afterID] from the current server
  Future<List<RessourcePreview>> getItems({int? afterID, int? count}) async {
    Map<String, dynamic> queryParams = {};
    if (afterID != null) {
      queryParams['afterID'] = afterID;
    }
    if (count != null) {
      queryParams['count'] = count;
    }
    JSONData responseBody = await _request(RequestType.get, '/items', params: queryParams);
    return (responseBody['items'] as List<JSONData>)
      .map((e) => RessourcePreview.fromJSON(e))
      .toList();
  }

  /// Retrieves a [Movie] (with its [Genre]s) from current server using its [Slug]
  Future<Movie> getMovie(Slug movieSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/shows/$movieSlug', params: {'fields': 'genres'});
    return Movie.fromJSON(responseBody);
  }

  /// Retrieves a [TVSeries] (with its [Genre]s and [Season]s) from current server using [TVSeries]'s [Slug]
  Future<TVSeries> getSeries(Slug seriesSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/shows/$seriesSlug', params: {'fields': 'genres,seasons'});
    return TVSeries.fromJSON(responseBody);
  }

  /// Retrieves [Episode]s of a [Season] from current server using [Season]'s [Slug]
  Future<List<Episode>> getEpisodes(Slug seasonSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/seasons/$seasonSlug/episodes', params: {'limit': '0'});
    return (responseBody['items'] as List)
      .map((item) => Episode.fromJSON(item))
      .toList();
  }

  /// Retrieves a [Collection] (including its [RessourcePreview]s ) using its [Slug]
  Future<Collection> getCollection(Slug collectionSlug) async {
    JSONData responseBody = await _request(RequestType.get, '/collections/$collectionSlug', params: {'fields': 'shows'});
    return Collection.fromJSON(responseBody);
  }

  /// Retrieves the server's [Librarie]s
  Future<List<Library>> getLibraries() async {
    JSONData responseBody = await _request(RequestType.get, '/libraries');
    return (responseBody['items'] as List)
      .map((e) => Library.fromJSON(e))
      .toList();
  }

  /// Request Kyoo's API, the route must not start with '/api'
  Future<JSONData> _request(RequestType type, String route, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    body ??= {};
    params ??= {};
    http.Response response;
    Uri fullRoute = Uri(host: serverURL, path: 'api$route', queryParameters: params);
    final Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
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
