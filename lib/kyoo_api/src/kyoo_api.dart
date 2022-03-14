import 'dart:convert';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:http/http.dart' as http;
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';

enum RequestType { get, post, put, delete }

/// Interface Class to communicate
class KyooAPI {
  /// URL to the Server to call when using member function of this instance of [KyooAPI]
  final String serverURL;

  // TODO: manage JWT

  KyooAPI({required this.serverURL});

  Future<List<RessourcePreview>> getItems({int? afterID, int? count}) async {
    Map<String, dynamic> queryParams = {};
    if (afterID != null) {
      queryParams['afterID'] = afterID;
    }
    if (count != null) {
      queryParams['count'] = count;
    }
    JSONData responseBody = await _request(RequestType.get, '/items', params: queryParams);
    return (responseBody['items'] as List)
      .map((e) => RessourcePreview.fromJSON(e))
      .toList();
  }

  Future<Movie> getMovie(String slug) async {
    JSONData responseBody = await _request(RequestType.get, '/shows/$slug', params: {'fields': 'genres'});
    return Movie.fromJSON(responseBody);
  }

  Future<TVSeries> getSeries(String slug) async {
    JSONData responseBody = await _request(RequestType.get, '/shows/$slug', params: {'fields': 'genres,seasons'});
    return TVSeries.fromJSON(responseBody);
  }

  Future<Collection> getCollection(String slug) async {
    JSONData responseBody = await _request(RequestType.get, '/collections/$slug');
    return Collection.fromJSON(responseBody);
  }

  Future<List<RessourcePreview>> getItems({int? afterID, int? count}) async {
    Map<String, dynamic> queryParams = {};
    if (afterID != null) {
      queryParams['afterID'] = afterID;
    }
    if (count != null) {
      queryParams['count'] = count;
    }
    JSONData responseBody = await _request(RequestType.get, '/items', params: queryParams);
    return (responseBody['items'] as List)
      .map((e) => RessourcePreview.fromJSON(e))
      .toList();
  }

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
