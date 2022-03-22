import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/kyoo_api/src/models/resource_preview.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/models/library_content.dart';

/// Action to set [LibraryContent] as currentLibrary from [AppState]
class SetCurrentLibraryAction extends ContainerAction<LibraryContent> {
  SetCurrentLibraryAction(LibraryContent library): super(content: library);
}

/// Action to set currentLibrary from [AppState] to null
class UnsetCurrentLibraryAction extends Action {}

/// Empty currentLibrary from [AppState]
class ResetCurrentLibraryAction extends Action {}


/// Action to set [LibraryContent]'s content
/// If [Library] field is null, fetch all
class LoadContentFromLibrary extends ContainerAction<LibraryContent?> {
  LoadContentFromLibrary(LibraryContent? library) : super(content: library);
}

/// Action to set [LibraryContent]s as [AppState]'s currentLibrary
class LoadedContentFromLibraryAction extends ContainerAction<List<ResourcePreview>> {
  LoadedContentFromLibraryAction(List<ResourcePreview> content) : super(content: content);
}

/// Action to set [LibraryContent] as fully loaded
class LibraryIsFullAction extends Action {}
