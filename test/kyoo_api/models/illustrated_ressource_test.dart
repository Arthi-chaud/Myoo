import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';

void main() {
  group('Illustrated Ressource', () {
    test('Default constructor', () {
      IllustratedRessource ressource = IllustratedRessource(
        id: 1,
        slug: 'slug',
        name: 'name',
        overview: 'overview',
        poster: 'poster',
        thumbnail: 'thumbnail');
      expect(ressource.id, 1);
      expect(ressource.slug, 'slug');
      expect(ressource.name, 'name');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview'
      };
      IllustratedRessource ressource = IllustratedRessource.fromJSON(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
    });

    test('Unserialize: Undefined "thumbnail" and "poster"', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'overview': 'overview'
      };
      IllustratedRessource ressource = IllustratedRessource.fromJSON(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, null);
      expect(ressource.thumbnail, null);
    });

    test('Unserialize: "thumbnail" and "poster" explicitly at null', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': null,
        'thumbnail': null,
        'overview': 'overview'
      };
      IllustratedRessource ressource = IllustratedRessource.fromJSON(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, null);
      expect(ressource.thumbnail, null);
    });
  });
}
