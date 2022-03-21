import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/episode.dart';

void main() {
  var now = DateTime.now();
  group('Episode', () {
    test('Default constructor', () {
      Episode resource = Episode(
          id: 1,
          slug: 'slug',
          name: 'name',
          overview: 'overview',
          thumbnail: 'thumbnail',
          releaseDate: now,
          absoluteIndex: 1,
          index: 2);
      expect(resource.id, 1);
      expect(resource.slug, 'slug');
      expect(resource.name, 'name');
      expect(resource.overview, 'overview');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
      expect(resource.absoluteIndex, 1);
      expect(resource.index, 2);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'trailer': 'trailer',
        'releaseDate': now.toIso8601String(),
        'absoluteNumber': 1,
        'episodeNumber': 2
      };
      Episode resource = Episode.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
      expect(resource.absoluteIndex, 1);
      expect(resource.index, 2);
    });

    test('Unserialize: Undefined "genres" and "trailer"', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'releaseDate': now.toIso8601String(),
      };
      Episode resource = Episode.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
      expect(resource.absoluteIndex, null);
      expect(resource.index, null);
    });
  });
}
