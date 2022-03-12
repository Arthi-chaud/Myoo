import 'package:myoo/kyoo_api/src/models/json.dart';
import 'package:myoo/kyoo_api/src/models/video.dart';

/// An Object Representation of an [Episode], usually from a [Season], itself from a [TVSeries]. It is a [Video]
class Episode extends Video {
  /// Absolute index of the episode in the parent [TVSeries], if applicable
  int? absoluteIndex;

  /// Index of the episode in the parent [Season], if applicable
  int? index;

  Episode.fromJSON(JSONData input):
    absoluteIndex = input['absoluteNumber'],
    index = input['episodeNumber'],
    super.fromJSON(input);
}
