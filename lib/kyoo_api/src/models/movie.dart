import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

/// A Movie is a [Video] that has [Genre]s
class Movie extends Video {
  /// List of genres to describe a [Movie]
  List<Genre> genres;

  Movie.fromJSON(JSONData input):
    genres = GenresParsing.fromJSON(input),
    super.fromJSON(input);
}
