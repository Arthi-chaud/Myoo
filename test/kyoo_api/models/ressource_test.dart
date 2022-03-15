import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/ressource.dart';

void main() {
  group('Ressource', () {
    test('Default constructor', () {
      Ressource ressource = Ressource(id: 123, slug: 'mySlug', name: 'myRessource', overview: 'My overview');
      expect(ressource.id, 123);
      expect(ressource.slug, 'mySlug');
      expect(ressource.name, 'myRessource');
      expect(ressource.overview, 'My overview');
    });
    test('All fields set (using "name")', () {
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

    test('All fields set (using "title")', () {
      JSONData input = {
        'id': 123,
        'slug': 'mySlug',
        'title': 'myRessource',
        'overview': 'My overview'
      };
      Ressource ressource = Ressource.fromJSON(input);
      expect(ressource.id, 123);
      expect(ressource.slug, 'mySlug');
      expect(ressource.name, 'myRessource');
      expect(ressource.overview, 'My overview');
    });

    test('"Overview" at null', () {
      JSONData input = {
        'id': 1234,
        'slug': 'mySlug1',
        'name': 'myRessource1',
        'overview': null
      };
      Ressource ressource = Ressource.fromJSON(input);
      expect(ressource.id, 1234);
      expect(ressource.slug, 'mySlug1');
      expect(ressource.name, 'myRessource1');
      expect(ressource.overview, '');
    });

    test('Undefined "Overview"', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myRessource2',
      };
      Ressource ressource = Ressource.fromJSON(input);
      expect(ressource.id, 12345);
      expect(ressource.slug, 'mySlug2');
      expect(ressource.name, 'myRessource2');
      expect(ressource.overview, '');
    });
  });
}
