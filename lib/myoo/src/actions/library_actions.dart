import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/illustrated_resource.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/myoo/src/actions/action.dart';


/// Action to set [Library] as currentLibrary from [AppState]
class SetCurrentLibraryAction extends ContainerAction<Library> {
  SetCurrentLibraryAction(Library library): super(content: library);
}

/// Action to set currentLibrary from [AppState] to null
class UnsetCurrentLibraryAction extends Action {}

