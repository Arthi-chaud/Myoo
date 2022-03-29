import 'package:myoo/kyoo_api/src/models/slug.dart';

/// Action to set/update the download progress of an item, identified by its [Slug]
class SetDownloadProgressAction {
  /// Download progress of the item
  final int progress;

  /// [Slug] of the downloading item
  final Slug itemSlug;

  const SetDownloadProgressAction(this.itemSlug, this.progress);
}
