import 'package:myoo/kyoo_api/src/models/json.dart';

/// A resource is an Object from the Kyoo API that can be identified with an id, a slug, an overview and a name  (for humans)
class Ressource {
  /// Unique identifier from Kyoo's Database
  int id;

  /// String identifier
  String slug;

  /// A display name for the ressource
  String name;

  /// A description of the ressource
  String overview;

  Ressource({required this.id, required this.slug, required this.name, required this.overview});

  Ressource.fromJSON(JSONData input): 
    id = input['id'],
    slug = input['slug'],
    name = input['title'],
    overview = input['overview'];
}
