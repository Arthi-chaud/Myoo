import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';

void main() {
  var now = DateTime.now();
  group('Collection', () {
    test('Default constructor', () {
      Collection resource = Collection(
          id: 1,
          slug: 'slug',
          name: 'name',
          overview: 'overview',
          poster: 'poster',
          thumbnail: 'thumbnail',
          content: []);
      expect(resource.id, 1);
      expect(resource.slug, 'slug');
      expect(resource.name, 'name');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.content, []);
    });

    test('Unserialize: All fields set', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'shows': [
          {
            'id': 12345,
            'slug': 'mySlug2',
            'name': 'myResource2',
            'poster': 'poster',
            'thumbnail': 'thumbnail',
            'overview': 'overview',
            'isMovie': true,
            'releaseDate': now.toIso8601String(),
          }
        ]
      };
      Collection resource = Collection.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.content.length, 1);
      ResourcePreview preview = resource.content[0];
      expect(preview.id, 12345);
      expect(preview.slug, 'mySlug2');
      expect(preview.name, 'myResource2');
      expect(preview.overview, 'overview');
      expect(preview.poster, 'poster');
      expect(preview.thumbnail, 'thumbnail');
      expect(preview.type, ResourcePreviewType.movie);
    });

    test('Unserialize: No content specified', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
      };
      Collection resource = Collection.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.content, []);
    });
  });
}
