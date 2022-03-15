import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';

void main() {
  group('Ressource Preview', () {
    test('Default constructor', () {
      RessourcePreview ressource = RessourcePreview(
        id: 1,
        slug: 'slug',
        name: 'name',
        overview: 'overview',
        poster: 'poster',
        thumbnail: 'thumbnail',
        type: RessourcePreviewType.movie
      );
      expect(ressource.id, 1);
      expect(ressource.slug, 'slug');
      expect(ressource.name, 'name');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.type, RessourcePreviewType.movie);
    });

    test('Unserialize: All fields set (using "releaseDate")', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'type': 0
      };
      RessourcePreview ressource = RessourcePreview.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.type, RessourcePreviewType.series);
    });
  });
}
