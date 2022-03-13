import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';

typedef IllustrationURL = String;

/// A [Ressource] that can have a Poster, and/or a thumbnail
class IllustratedRessource extends Ressource {
  /// URL of the Poster of the [Ressource], if it has one.
  IllustrationURL? poster;

  /// URL of the Thumbnail of the [Ressource], if it has one.
  IllustrationURL? thumbnail;

  IllustratedRessource({
    required int id,
    required String slug,
    required String name,
    required String overview,
    this.poster,
    this.thumbnail
  }) : super(id: id, slug: slug, name: name, overview: overview);

  IllustratedRessource.fromJSON(JSONData input) :
    poster = input['poster'],
    thumbnail = input['thumbnail'],
    super.fromJSON(input);

}
