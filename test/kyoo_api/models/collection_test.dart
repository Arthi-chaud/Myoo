import 'dart:convert';
import 'dart:io';

import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:test/test.dart';
import 'package:myoo/kyoo_api/src/models/collection.dart';

void main() {
  group('Collection', () {
    test('From JSON', () async {
      JSONData jsonCollection = jsonDecode(await File('test/kyoo_api/assets/collection.json').readAsString());
      Collection collection = Collection.fromJson(jsonCollection);

      expect(collection.id, 1);
      expect(collection.slug, 'george-melies');
      expect(collection.name, 'George Melies');
      expect(collection.overview, null);
      expect(collection.poster, '/api/collection/george-melies/poster');
      expect(collection.thumbnail, null);
      expect(collection.content.length, 2);

      expect(collection.content.first.type, ResourcePreviewType.movie);
      expect(collection.content.first.id, 5);
      expect(collection.content.first.slug, "a-trip-to-the-moon");
      expect(collection.content.first.name, "A Trip To The Moon");
      expect(collection.content.first.overview, "Professor Barbenfouillis and five of his colleagues from the Academy of Astronomy travel to the Moon aboard a rocket propelled by a giant cannon. Once on the lunar surface, the bold explorers face the many perils hidden in the caves of the mysterious satellite.");
      expect(collection.content.first.poster, '/api/show/a-trip-to-the-moon/poster');
      expect(collection.content.first.thumbnail, '/api/show/a-trip-to-the-moon/thumbnail');
      expect(collection.content.first.minDate, DateTime(1902));
      expect(collection.content.first.maxDate, DateTime(1902, 4, 17));

      expect(collection.content.last.type, ResourcePreviewType.movie);
      expect(collection.content.last.id, 6);
      expect(collection.content.last.slug, 'cinderella');
      expect(collection.content.last.name, 'Cinderella');
      expect(collection.content.last.overview, "A fairy godmother magically turns Cinderella's rags to a beautiful dress, and a pumpkin into a coach. Cinderella goes to the ball, where she meets the Prince - but will she remember to leave before the magic runs out?  Méliès based the art direction on engravings by Gustave Doré. First known example of a fairy-tale adapted to film, and the first film to use dissolves to go from one scene to another.");
      expect(collection.content.last.poster, '/api/show/cinderella/poster');
      expect(collection.content.last.thumbnail, null);
      expect(collection.content.last.minDate,  DateTime(1899));
      expect(collection.content.last.maxDate,  DateTime(1899, 10));
    });
  });
}
