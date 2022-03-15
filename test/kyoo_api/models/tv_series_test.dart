import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:test/test.dart';

void main() {
  var now = DateTime.now();
  var genres = ['Action', 'Adventure', "Express"];
  group('TVSeries', () {
    test('Default constructor', () {
      TVSeries ressource = TVSeries(
        id: 1,
        slug: 'slug',
        name: 'name',
        overview: 'overview',
        poster: 'poster',
        thumbnail: 'thumbnail',
        genres: genres,
        trailer: "trailer",
        seasons: []
      );
      expect(ressource.id, 1);
      expect(ressource.slug, 'slug');
      expect(ressource.name, 'name');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.seasons, []);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'trailer': 'trailer',
        'genres': [
          {'id': 1, 'name': 'Action'},
          {'id': 2, 'name': 'Adventure'},
          {'id': 3, 'name': 'Express'}
        ],
        'seasons': [
          {
            'id': 12345,
            'slug': 'mySlug2',
            'name': 'myRessource2',
            'poster': 'poster',
            'thumbnail': 'thumbnail',
            'overview': 'overview',
            'seasonNumber': 1,
            'episodes': [
              {
                'id': 12345,
                'slug': 'mySlug2',
                'name': 'myRessource2',
                'thumbnail': 'thumbnail',
                'overview': 'overview',
                'releaseDate': now.toIso8601String(),
                'absoluteNumber': 1,
                'episodeNumber': 2
              }
            ]
          }
        ]
      };
      TVSeries ressource = TVSeries.fromJson(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, 'overview');
      expect(ressource.poster, 'poster');
      expect(ressource.thumbnail, 'thumbnail');
      expect(ressource.genres, genres);
      expect(ressource.trailer, 'trailer');
      expect(ressource.seasons.length, 1);
      Season season = ressource.seasons[0];
      expect(season.id, 12345);
      expect(season.index, 1);
      expect(season.slug, 'mySlug2');
      expect(season.name, 'myRessource2');
      expect(season.overview, 'overview');
      expect(season.poster, 'poster');
      expect(season.thumbnail, 'thumbnail');
      expect(season.episodes.length, 1);
      Episode episode = season.episodes[0];
      expect(episode.id, 12345);
      expect(episode.slug, 'mySlug2');
      expect(episode.name, 'myRessource2');
      expect(episode.overview, 'overview');
      expect(episode.releaseDate, now);
      expect(episode.thumbnail, 'thumbnail');
      expect(episode.absoluteIndex, 1);
      expect(episode.index, 2);
    });
  });
}
