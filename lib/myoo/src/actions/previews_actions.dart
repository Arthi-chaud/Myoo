import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';
import 'package:myoo/myoo/src/actions/action.dart';


/// Action to set [Preview]s as [AppState]'s list of [Preview]s
class LoadedPreviewsAction extends ContainerAction<List<RessourcePreview>> {
  LoadedPreviewsAction(List<RessourcePreview> previews) : super(content: previews);
}

/// Action to unload [AppState]'s current [Preview]s
class UnloadPreviewsAction extends Action {}
