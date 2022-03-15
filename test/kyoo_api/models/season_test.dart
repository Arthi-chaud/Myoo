import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:test/test.dart';

void main() {
  var now = DateTime.now();
  group('Season', () {
    test('Default constructor', () {
      Season ressource = Season(
        id: 1,
        slug: 'slug',
        name: 'name',
        overview: 'overview',
        poster: 'poster',
        thumbnail: 'thumbnail',
        index: 3,
        episodes: []
      );
      expect(ressource.id, 1);
      expect(ressource.slug, 'slug');
      expect(ressource.name, 'name');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.episodes, []);
      expect(ressource.index, 3);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'episodes': [{
          'id': 12345,
          'slug': 'mySlug2',
          'name': 'myRessource2',
          'poster': 'poster',
          'thumbnail': 'thumbnail',
          'overview': 'overview',
          'trailer': 'trailer',
          'releaseDate': now.toIso8601String(),
          'absoluteNumber': 1,
          'episodeNumber': 2
        }]
      };
      Season ressource = Season.fromJSON(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.episodes, [
        Episode(id: 12345, slug: 'mySlug2', name: 'myRessource2', overview: 'overview', releaseDate: now, poster: 'poster', thumbnail: 'thumbnail', absoluteIndex: 1, index: 2)
      ]);
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
      Season ressource = Season.fromJSON(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.episodes, []);
    });
  });
}
