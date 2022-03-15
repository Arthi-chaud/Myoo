import 'package:myoo/kyoo_api/src/models/json.dart';

typedef Genre = String;

extension GenreParsing on String {
  static Genre fromJson(JSONData input) => input['name'];
}

extension GenresParsing on String {
  static List<Genre> fromJson(List input) =>
    input
      .map((genre) => GenreParsing.fromJson(genre))
      .toList();
}
