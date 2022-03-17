import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:test/test.dart';

void main() {
  var now = DateTime.now();
  group('Season', () {
    test('Default constructor', () {
      Season ressource = const Season(
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
        'seasonNumber': 42,
        'episodes': [{
          'id': 12345,
          'slug': 'mySlug2',
          'name': 'myRessource2',
          'overview': 'overview',
          'releaseDate': now.toIso8601String(),
          'thumbnail': 'thumbnail',
          'absoluteNumber': 1,
          'episodeNumber': 2
        }]
      };
      Season ressource = Season.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.index, 42);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.episodes.length, 1);
      Episode episode = ressource.episodes[0];
      expect(episode.id, 12345);
      expect(episode.slug, 'mySlug2');
      expect(episode.name, 'myRessource2');
      expect(episode.overview, 'overview');
      expect(episode.releaseDate, now);
      expect(episode.thumbnail, 'thumbnail');
      expect(episode.absoluteIndex, 1);
      expect(episode.index, 2);
    });

    test('Unserialize: No content specified', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'seasonNumber': 456,
        'thumbnail': 'thumbnail',
        'overview': 'overview',
      };
      Season ressource = Season.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.index, 456);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.episodes, []);
    });
  });
}
