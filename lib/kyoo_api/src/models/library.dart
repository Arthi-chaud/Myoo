import 'package:myoo/kyoo_api/kyoo_api.dart';

/// A Librayr holds [Movie]s, [Collection]s, and/or [TVSeries]
class Library extends Ressource {
  /// The content of the library
  List<IllustratedRessource> content;

  Library.fromJSON(JSONData input):
    super.fromJSON(input)
}
