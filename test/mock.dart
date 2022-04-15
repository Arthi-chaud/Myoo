import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

MockClient mockKyooAPI(Map<String, String> responses) {
  responses['/api/libraries'] ??= '{"items": []}';
  responses['/api/items'] ??= '{"items": []}';
  return MockClient((Request request) async {
    for (String route in responses.keys) {
      if (request.url.path == route) {
        return http.Response(responses[route]!, 200, headers: {'content-type': 'text/html; charset=utf-8'});
      }
    }
    return http.Response('${request.url.path}: Route not known', 404, headers: {'content-type': 'text/html; charset=utf-8'});
  });
}
