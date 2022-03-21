import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/resource.dart';

void main() {
  group('Resource', () {
    test('Default constructor', () {
      Resource resource = const Resource(
          id: 123, slug: 'mySlug', name: 'myResource', overview: 'My overview');
      expect(resource.id, 123);
      expect(resource.slug, 'mySlug');
      expect(resource.name, 'myResource');
      expect(resource.overview, 'My overview');
    });
    test('Unserialize: All fields set (using "name")', () {
      JSONData input = {
        'id': 123,
        'slug': 'mySlug',
        'name': 'myResource',
        'overview': 'My overview'
      };
      Resource resource = Resource.fromJson(input);
      expect(resource.id, 123);
      expect(resource.slug, 'mySlug');
      expect(resource.name, 'myResource');
      expect(resource.overview, 'My overview');
    });

    test('Unserialize: All fields set (using "title")', () {
      JSONData input = {
        'id': 123,
        'slug': 'mySlug',
        'title': 'myResource',
        'overview': 'My overview'
      };
      Resource resource = Resource.fromJson(input);
      expect(resource.id, 123);
      expect(resource.slug, 'mySlug');
      expect(resource.name, 'myResource');
      expect(resource.overview, 'My overview');
    });

    test('Unserialize: "Overview" at null', () {
      JSONData input = {
        'id': 1234,
        'slug': 'mySlug1',
        'name': 'myResource1',
        'overview': null
      };
      Resource resource = Resource.fromJson(input);
      expect(resource.id, 1234);
      expect(resource.slug, 'mySlug1');
      expect(resource.name, 'myResource1');
      expect(resource.overview, '');
    });

    test('Unserialize: Undefined "Overview"', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
      };
      Resource resource = Resource.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, '');
    });
  });
}
