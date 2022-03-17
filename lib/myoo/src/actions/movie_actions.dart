import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [Movie] as [AppState]'s current [Movie]
class LoadMovie extends ContainerAction<Slug> {
  LoadMovie(Slug movieSlug) : super(content: movieSlug);
}

/// Action to unload [AppState]'s current [Movie]
class UnloadMovie extends Action {}
