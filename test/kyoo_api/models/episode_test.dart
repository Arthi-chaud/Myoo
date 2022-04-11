import 'dart:convert';
import 'dart:io';
import 'package:myoo/kyoo_api/src/models/episode.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';

void main() {
  group('Episode', () {
    test('From JSON', () async {
      JSONData jsonEpisode = jsonDecode(await File('test/kyoo_api/assets/episode.json').readAsString());
      Episode episode = Episode.fromJson(jsonEpisode);

      expect(episode.id, 7);
      expect(episode.slug, 'pioneer-one-s1e1');
      expect(episode.name, "Earthfall");
      expect(episode.overview,  "An object from space spreads radiation over North America. Fearing terrorism, U.S. Homeland Security agents are dispatched to investigate and contain the damage. What they discover is a forgotten relic of the old Soviet space program, whose return to Earth will have implications for the entire world.");
      expect(episode.releaseDate, DateTime(2010, 6, 16));
      expect(episode.thumbnail, "/api/episode/pioneer-one-s1e1/thumbnail");
      expect(episode.absoluteIndex, null);
      expect(episode.index, 1);
    });
  });
}
