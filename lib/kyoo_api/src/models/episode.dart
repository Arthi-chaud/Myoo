import 'dart:core';
import 'package:myoo/kyoo_api/src/models/video.dart';

/// An Object Representation of an [Episode], usually from a [Season], itself from a [TVSeries]. It is a [Video]
class Episode extends Video {
  /// Date of the Episode's first air
  DateTime firstAirDate;
  /// Absolute index of the episode in the parent [TVSeries]
  int absoluteIndex;
  /// Index of the episode in the parent [Season]
  int index;
}
