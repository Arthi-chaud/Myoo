import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:test/test.dart';

void main() {
  var now = DateTime.now();
  group('Season', () {
    test('Default constructor', () {
      Season resource = const Season(
          id: 1,
          slug: 'slug',
          name: 'name',
          overview: 'overview',
          poster: 'poster',
          thumbnail: 'thumbnail',
          index: 3,
          episodes: []);
      expect(resource.id, 1);
      expect(resource.slug, 'slug');
      expect(resource.name, 'name');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.episodes, []);
      expect(resource.index, 3);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'seasonNumber': 42,
        'episodes': [
          {
            'id': 12345,
            'slug': 'mySlug2',
            'name': 'myResource2',
            'overview': 'overview',
            'releaseDate': now.toIso8601String(),
            'thumbnail': 'thumbnail',
            'absoluteNumber': 1,
            'episodeNumber': 2
          }
        ]
      };
      Season resource = Season.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.index, 42);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.episodes.length, 1);
      Episode episode = resource.episodes[0];
      expect(episode.id, 12345);
      expect(episode.slug, 'mySlug2');
      expect(episode.name, 'myResource2');
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
        'name': 'myResource2',
        'poster': 'poster',
        'seasonNumber': 456,
        'thumbnail': 'thumbnail',
        'overview': 'overview',
      };
      Season resource = Season.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.index, 456);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.episodes, []);
    });
  });
}
