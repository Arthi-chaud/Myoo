import 'package:myoo/kyoo_api/src/models/genre.dart';
import 'package:myoo/kyoo_api/src/models/trailer_url.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

/// A Movie is a [Video] that has [Genre]s
class Movie extends Video {
  /// List of genres to describe a [Movie]
  List<Genre> genres;

  /// External URL to the [Movie]'s trailer 
  TrailerURL trailer;

  Movie.fromJSON(JSONData input):
    genres = GenresParsing.fromJSON(input),
    trailer = TrailerParsing.fromJSON(input),
    super.fromJSON(input);
}
