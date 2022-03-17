import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [TVSeries] as [AppState]'s current [TVSeries]
class LoadTVSeries extends ContainerAction<Slug> {
  LoadTVSeries(Slug seriesSlug) : super(content: seriesSlug);
}

/// Action to set [TVSeries] as [AppState]'s current [TVSeries]
class LoadedTVSeries extends ContainerAction<TVSeries> {
  LoadedTVSeries(TVSeries series) : super(content: series);
}

/// Action to unload [AppState]'s current [TVSeries]
class UnloadTVSeries extends Action {}
