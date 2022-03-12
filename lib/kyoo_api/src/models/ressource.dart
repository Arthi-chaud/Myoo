/// A resource is an Object from the Kyoo API that can be identified with an id, a slug, and a name  (for humans)
class Ressource {
  /// Unique identifier from Kyoo's Database
  int id;

  /// String identifier
  String slug;

  /// A display name for the ressource
  String name;

  Ressource({required this.id, required this.slug, required this.name});
}
