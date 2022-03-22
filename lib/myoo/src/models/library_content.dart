import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';

/// Wrapper for [Library] content, make progressing loading easier
class LibraryContent {
  /// Holding [Library]
  /// If null, the object holds content from all server
  final Library? library;

  /// Have all the [Library]'s content been loaded
  final bool fullyLoaded;

  /// Content collection
  final List<ResourcePreview> content;

  const LibraryContent({this.library, this.fullyLoaded = false, this.content = const []});
}
