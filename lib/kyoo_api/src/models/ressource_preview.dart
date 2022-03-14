import 'package:myoo/kyoo_api/kyoo_api.dart';

enum RessourcePreviewType {
  series, // Implicit 0
  movie, // Implicit 1
  collection, // Implicit 2
}

/// A [RessourcePreview] is mostly seen as a tile from the Home Page
class RessourcePreview extends IllustratedRessource {
  /// The type of the previwed [Ressource]
  RessourcePreviewType type;

  RessourcePreview.fromJSON(JSONData input):
    type = input['type'],
    super.fromJSON(input);
}
