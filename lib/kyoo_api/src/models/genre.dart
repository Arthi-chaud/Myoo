import 'package:myoo/kyoo_api/src/models/json.dart';

typedef Genre = String;

extension GenreParsing on String {
  static Genre fromJSON(JSONData input) => input['name'];
}

extension GenresParsing on String {
  static List<Genre> fromJSON(List input) =>
    input
      .map((genre) => GenreParsing.fromJSON(genre))
      .toList();
}
