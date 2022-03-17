import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [Season] as [AppState]'s current [Season]
class LoadSeason extends ContainerAction<Slug> {
  LoadSeason(Slug seasonSlug) : super(content: seasonSlug);
}

/// Action to set [Season] as [AppState]'s current [Season]
class LoadedSeason extends ContainerAction<Season> {
  LoadedSeason(Season season) : super(content: season);
}

/// Action to unload [AppState]'s current [Season]
class UnloadSeason extends Action {}
