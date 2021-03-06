import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [TVSeries] as [AppState]'s current [TVSeries]
class LoadTVSeriesAction extends ContainerAction<Slug> {
  LoadTVSeriesAction(Slug seriesSlug) : super(content: seriesSlug);
}

/// Action to set [TVSeries] as [AppState]'s current [TVSeries]
class LoadedTVSeriesAction extends ContainerAction<TVSeries> {
  LoadedTVSeriesAction(TVSeries series) : super(content: series);
}

/// Action to set [TVSeries]? as [AppState]'s current [TVSeries]
class SetCurrentTVSeries extends ContainerAction<TVSeries?> {
  SetCurrentTVSeries(TVSeries? series) : super(content: series);
}

/// Action to unload [AppState]'s current [TVSeries]
class UnloadTVSeriesAction extends Action {}
