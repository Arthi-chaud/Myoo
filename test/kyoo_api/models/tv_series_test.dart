import 'dart:convert';
import 'dart:io';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:test/test.dart';

void main() {
  group('TVSeries', () {
    test('From JSON', () async {
      JSONData jsonSeries = jsonDecode(await File('test/kyoo_api/assets/tv_series.json').readAsString());
      TVSeries series = TVSeries.fromJson(jsonSeries);

      expect(series.id, 3);
      expect(series.slug, 'pioneer-one');
      expect(series.name, "Pioneer One");
      expect(series.overview,  "Pioneer One is a 2010 American web series produced by Josh Bernhard and Bracey Smith. It has been funded purely through donations, and is the first series created for and released on BitTorrent networks.");
      expect(series.releaseDate, DateTime(2010, 6, 16));
      expect(series.endDate, DateTime(2011, 12, 13));
      expect(series.poster, '/api/show/pioneer-one/poster');
      expect(series.thumbnail, "/api/show/pioneer-one/thumbnail");
      expect(series.trailer, "https://www.youtube.com/watch?v=icLQqVDk86Y");
      expect(series.studio, 'lastsat productions');
      expect(series.staff, []);
      expect(series.genres, ['Drama', 'Science Fiction']);
      expect(series.seasons, []);

      expect(series.externalIDs.length, 1);
      expect(series.externalIDs.first.externalURL, 'https://www.thetvdb.com/series/pioneer-one');
      expect(series.externalIDs.first.provider.id, 1);
      expect(series.externalIDs.first.provider.slug, 'the-tvdb');
      expect(series.externalIDs.first.provider.name, 'TheTVDB');
      expect(series.externalIDs.first.provider.logo, "/api/provider/the-tvdb/logo");
    });
  });
}
