import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [Season] as [AppState]'s current [Season]
class LoadSeasonAction extends ContainerAction<Slug> {
  LoadSeasonAction(Slug seasonSlug) : super(content: seasonSlug);
}

/// Action to set [Season] as [AppState]'s current [Season]
class LoadedSeasonAction extends ContainerAction<Season> {
  LoadedSeasonAction(Season season) : super(content: season);
}

/// Action to unload [AppState]'s current [Season]
class UnloadSeasonAction extends Action {}
