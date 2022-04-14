import 'dart:convert';
import 'dart:io';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/movie.dart';

void main() {
  group('Movie', () {
    test('From JSON', () async {
      JSONData jsonMovie = jsonDecode(await File('test/kyoo_api/assets/movie.json').readAsString());
      Movie movie = Movie.fromJson(jsonMovie);

      expect(movie.id, 2);
      expect(movie.slug, 'big-buck-bunny');
      expect(movie.name, "Big Buck Bunny");
      expect(movie.overview,  "Follow a day of the life of Big Buck Bunny when he meets three bullying rodents: Frank, Rinky, and Gamera. The rodents amuse themselves by harassing helpless creatures by throwing fruits, nuts and rocks at them. After the deaths of two of Bunny's favorite butterflies, and an offensive attack on Bunny himself, Bunny sets aside his gentle nature and orchestrates a complex plan for revenge.");
      expect(movie.releaseDate, DateTime(2008, 4, 10));
      expect(movie.poster, '/api/show/big-buck-bunny/poster');
      expect(movie.thumbnail, "/api/show/big-buck-bunny/thumbnail");
      expect(movie.trailer, "https://www.youtube.com/watch?v=yUQM7H4Swgw");
      expect(movie.studio, 'Blender Foundation');
      expect(movie.staff, []);
      expect(movie.externalIDs.length, 1);
      expect(movie.externalIDs.first.externalURL, 'https://www.themoviedb.org/movie/10378');
      expect(movie.externalIDs.first.provider.id, 2);
      expect(movie.externalIDs.first.provider.slug, 'the-moviedb');
      expect(movie.externalIDs.first.provider.name, 'TheMovieDB');
      expect(movie.externalIDs.first.provider.logo, "/api/provider/the-moviedb/logo");
    });
  });
}
