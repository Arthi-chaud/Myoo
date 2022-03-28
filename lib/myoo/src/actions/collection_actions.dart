import 'package:myoo/kyoo_api/src/models/collection.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [Collection] as [AppState]'s current [Collection]
class LoadCollectionAction extends ContainerAction<Slug> {
  LoadCollectionAction(Slug movieSlug) : super(content: movieSlug);
}

/// Action to set [Collection] as [AppState]'s current [Collection]
class LoadedCollectionAction extends ContainerAction<Collection> {
  LoadedCollectionAction(Collection collection) : super(content: collection);
}

/// Action to set [Collection]? as [AppState]'s current [Collection]
class SetCurrentCollection extends ContainerAction<Collection?> {
  SetCurrentCollection(Collection? collection) : super(content: collection);
}

/// Action to unload [AppState]'s current [Collection]
class UnloadCollectionAction extends Action {}
