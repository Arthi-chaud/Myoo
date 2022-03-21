import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to set [Preview]s as [AppState]'s list of [Preview]s
/// If [Library] is null, fetch all
class LoadPreviewsFromLibrary extends ContainerAction<Library?> {
  LoadPreviewsFromLibrary(Library? library) : super(content: library);
}

/// Action to set [Preview]s as [AppState]'s list of [Preview]s
class LoadedPreviewsAction extends ContainerAction<List<ResourcePreview>> {
  LoadedPreviewsAction(List<ResourcePreview> previews) : super(content: previews);
}

/// Action to unload [AppState]'s current [Preview]s
class UnloadPreviewsAction extends Action {}
