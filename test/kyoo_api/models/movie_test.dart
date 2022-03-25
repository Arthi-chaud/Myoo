import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/movie.dart';

void main() {
  var now = DateTime.now();
  var genres = ['Action', 'Adventure', "Express"];
  group('Movie', () {
    test('Default constructor', () {
      Movie resource = Movie(
          id: 1,
          slug: 'slug',
          name: 'name',
          overview: 'overview',
          poster: 'poster',
          thumbnail: 'thumbnail',
          releaseDate: now,
          genres: genres,
          studio: 'Pixar',
          trailer: "trailer");
      expect(resource.id, 1);
      expect(resource.slug, 'slug');
      expect(resource.name, 'name');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
      expect(resource.genres, genres);
      expect(resource.trailer, 'trailer');
      expect(resource.studio, 'Pixar');
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'trailer': 'trailer',
        'studio': 'studio',
        'releaseDate': now.toIso8601String(),
        'genres': [
          {'id': 1, 'name': 'Action'},
          {'id': 2, 'name': 'Adventure'},
          {'id': 3, 'name': 'Express'}
        ]
      };
      Movie resource = Movie.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
      expect(resource.genres, genres);
      expect(resource.trailer, 'trailer');
      expect(resource.studio, 'studio');
    });

    test('Unserialize: Undefined "genres", "trailer" and "stdio', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'releaseDate': now.toIso8601String(),
      };
      Movie resource = Movie.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
      expect(resource.genres, []);
      expect(resource.trailer, null);
      expect(resource.studio, null);
    });
  });
}
