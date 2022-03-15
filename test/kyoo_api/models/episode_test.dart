import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/episode.dart';

void main() {
  var now = DateTime.now();
  var genres = ['Action', 'Adventure', "Express"];
  group('Episode', () {
    test('Default constructor', () {
      Episode ressource = Episode(
        id: 1,
        slug: 'slug',
        name: 'name',
        overview: 'overview',
        thumbnail: 'thumbnail',
        releaseDate: now,
        absoluteIndex: 1,
        index: 2
      );
      expect(ressource.id, 1);
      expect(ressource.slug, 'slug');
      expect(ressource.name, 'name');
      expect(ressource.overview, 'overview');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.releaseDate, now);
      expect(ressource.absoluteIndex, 1);
      expect(ressource.index, 2);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'trailer': 'trailer',
        'releaseDate': now.toIso8601String(),
        'absoluteNumber': 1,
        'episodeNumber': 2
      };
      Episode ressource = Episode.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.releaseDate, now);
      expect(ressource.absoluteIndex, 1);
      expect(ressource.index, 2);
    });

    test('Unserialize: Undefined "genres" and "trailer"', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'releaseDate': now.toIso8601String(),
      };
      Episode ressource = Episode.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.releaseDate, now);
      expect(ressource.absoluteIndex, null);
      expect(ressource.index, null);
    });

  });
}
