import 'package:myoo/kyoo_api/src/models/json.dart';

typedef TrailerURL = String;

extension TrailerParsing on String {
  static TrailerURL fromJSON(JSONData input) => input['trailerUrl'];
}
