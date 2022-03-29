import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/download_action.dart';
import 'package:redux/redux.dart';

final currentDownloadProgressReducers = combineReducers<Map<Slug, int>>([
  TypedReducer<Map<Slug, int>, SetDownloadProgressAction>(updateDownloadProgress),
]);

Map<Slug, int> updateDownloadProgress(Map<Slug, int> oldProgress, action) {
  Map<Slug, int> newProgressState = Map.from(oldProgress);
  SetDownloadProgressAction downloadAction = action;
  newProgressState[downloadAction.itemSlug] = downloadAction.progress;
  return newProgressState;
}
