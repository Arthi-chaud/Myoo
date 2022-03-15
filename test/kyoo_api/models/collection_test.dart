import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';

void main() {
  var now = DateTime.now();
  group('Collection', () {
    test('Default constructor', () {
      Collection ressource = Collection(
        id: 1,
        slug: 'slug',
        name: 'name',
        overview: 'overview',
        poster: 'poster',
        thumbnail: 'thumbnail',
        content: []
      );
      expect(ressource.id, 1);
      expect(ressource.slug, 'slug');
      expect(ressource.name, 'name');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.content, []);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'shows': [{
          'id': 12345,
          'slug': 'mySlug2',
          'name': 'myRessource2',
          'poster': 'poster',
          'thumbnail': 'thumbnail',
          'overview': 'overview',
          'isMovie': true,
          'releaseDate': now.toIso8601String(),
        }]
      };
      Collection ressource = Collection.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.content.length, 1);
      RessourcePreview preview = ressource.content[0];
      expect(preview.id, 12345);
      expect(preview.slug, 'mySlug2');
      expect(preview.name, 'myRessource2');
      expect(preview.overview, 'overview');
      expect(preview.poster, 'poster');
      expect(preview.thumbnail, 'thumbnail');
      expect(preview.type, RessourcePreviewType.movie);
    });

    test('Unserialize: No content specified', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
      };
      Collection ressource = Collection.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.content, []);
    });
  });
}
