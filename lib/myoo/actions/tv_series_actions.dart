import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/actions/action.dart';

/// Action to load [TVSeries] as [AppState]'s current [TVSeries]
class LoadTVSeries extends ContainerAction<Slug> {
  LoadTVSeries(Slug seriesSlug) : super(content: seriesSlug);
}

/// Action to unload [AppState]'s current [TVSeries]
class UnloadTVSeries extends Action {}
