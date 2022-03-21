import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';

void main() {
  var now = DateTime.now();
  group('Video', () {
    test('Default constructor', () {
      Video resource = Video(
          id: 1,
          slug: 'slug',
          name: 'name',
          overview: 'overview',
          poster: 'poster',
          thumbnail: 'thumbnail',
          releaseDate: now);
      expect(resource.id, 1);
      expect(resource.slug, 'slug');
      expect(resource.name, 'name');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
    });

    test('Unserialize: All fields set (using "releaseDate")', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'releaseDate': now.toIso8601String()
      };
      Video resource = Video.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
    });

    test('Unserialize: All fields set (using "startAir")', () {
      JSONData input = {
        'id': 12345,
        'slug': 'mySlug2',
        'name': 'myResource2',
        'poster': 'poster',
        'thumbnail': 'thumbnail',
        'overview': 'overview',
        'startAir': now.toIso8601String()
      };
      Video resource = Video.fromJson(input);
      expect(resource.id, 12345);
      expect(resource.slug, 'mySlug2');
      expect(resource.name, 'myResource2');
      expect(resource.overview, 'overview');
      expect(resource.poster, 'poster');
      expect(resource.thumbnail, 'thumbnail');
      expect(resource.releaseDate, now);
    });
  });
}
