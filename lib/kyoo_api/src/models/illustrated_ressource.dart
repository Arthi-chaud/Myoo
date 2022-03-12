import 'package:myoo/kyoo_api/src/models/ressource.dart';

/// A [Ressource] that can have a Poster, and/or a thumbnail

typedef IllustrationURL = String;

class IllustratedRessource extends Ressource {
  /// URL of the Poster of the [Ressource], if it has one.
  IllustrationURL? poster;
    /// URL of the Thumbnail of the [Ressource], if it has one.
  IllustrationURL? thumbnail;
}
