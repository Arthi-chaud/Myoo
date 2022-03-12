import 'package:myoo/kyoo_api/src/models/illustrated_ressource.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

/// A [IllustratedRessource] that has duration and an air date
class Video extends IllustratedRessource {
  /// Date of the Episode's first air, or day of release
  DateTime firstAirDate;

  Video.fromJSON(JSONData input):
    firstAirDate = input['releaseDate'],
    super.fromJSON(input);
}
