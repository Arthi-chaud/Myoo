import 'dart:convert';
import 'dart:io';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';

void main() {
  group('Library', () {
    test('From JSON', () async {
      JSONData jsonLibrary = jsonDecode(await File('test/kyoo_api/assets/library.json').readAsString());
      Library library = Library.fromJson(jsonLibrary);

      expect(library.id, 1);
      expect(library.slug, 'Movies');
      expect(library.name, "Films");
      expect(library.overview, null);
    });
  });
}
