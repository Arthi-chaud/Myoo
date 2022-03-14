import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';

void main() {
  group('Ressource', () {
    test('All fields set', () {
      JSONData input = {
        'id': 123,
        'slug': 'mySlug',
        'name': 'myRessource',
        'overview': 'My overview'
      };
      Ressource ressource = Ressource.fromJSON(input);
      expect(ressource.id, 123);
      expect(ressource.slug, 'mySlug');
      expect(ressource.name, 'myRessource');
      expect(ressource.overview, 'My overview');
    });
  });
}
