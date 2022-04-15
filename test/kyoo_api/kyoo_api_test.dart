import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';

import '../mock.dart';

void main() async {
  const String slug = 'bla';
  const String serverUrl = 'toto';
  KyooClient client = KyooClient(
    serverURL: serverUrl,
    client: mockKyooAPI({
      '/api/watch/$slug': '{"container": "avi"}'
    })
  );
  group('Kyoo API', () {
    test('Get Video Download Link', () async {
      expect(
        client.getVideoDownloadLink(slug),
        'http://toto/video/$slug'
      );
    });
    test('Get Video Subtitle DL Link', () async {
      expect(
        client.getSubtitleTrackDownloadLink("$slug-eng", 'ass'),
        'http://toto/subtitles/$slug-eng.ass'
      );
    });

    test('Get Video Subtitle DL Link (SRT)', () async {
      expect(
        client.getSubtitleTrackDownloadLink("$slug-eng", 'subrip'),
        'http://toto/subtitles/$slug-eng.srt'
      );
    });

    test('Get Direct Streaming Link', () async {
      expect(
        client.getStreamingLink(slug, StreamingMethod.direct),
        'http://toto/videos/direct/$slug'
      );
    });

    test('Get Transmux Streaming Link', () async {
      expect(
        client.getStreamingLink(slug, StreamingMethod.transmux),
        'http://toto/videos/transmux/$slug/master.m3u8'
      );
    });

    test('Get Video extension', () async {
      expect(
        await client.getFileExtension(slug),
        'avi'
      );
    });
  });
}
