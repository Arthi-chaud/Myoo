import 'dart:convert';
import 'dart:io';
import 'package:myoo/kyoo_api/src/models/season.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:test/test.dart';

void main() {
  group('Season', () {
    test('From JSON', () async {
      JSONData jsonSeason = jsonDecode(await File('test/kyoo_api/assets/season.json').readAsString());
      Season season = Season.fromJson(jsonSeason);
      expect(season.id, 285);
      expect(season.slug, 'aggretsuko-s1');
      expect(season.name, "Season 1");
      expect(season.overview,  "Frustrated with her thankless office job, Retsuko the Red Panda copes with her daily struggles by belting out death metal karaoke after work.");
      expect(season.poster, "/api/season/aggretsuko-s1/poster");
      expect(season.thumbnail, null);
      expect(season.index, 1);
      expect(season.episodes, []);
    });
  });
}
