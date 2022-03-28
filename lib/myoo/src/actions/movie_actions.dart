import 'package:myoo/kyoo_api/src/models/movie.dart';
import 'package:myoo/kyoo_api/src/models/slug.dart';
import 'package:myoo/myoo/src/actions/action.dart';

/// Action to load [Movie] as [AppState]'s current [Movie]
class LoadMovieAction extends ContainerAction<Slug> {
  LoadMovieAction(Slug movieSlug) : super(content: movieSlug);
}

/// Action to set [Movie] as [AppState]'s current [Movie]
class LoadedMovieAction extends ContainerAction<Movie> {
  LoadedMovieAction(Movie movie) : super(content: movie);
}

/// Action to set [Movie]? as [AppState]'s current [Movie]
class SetCurrentMovie extends ContainerAction<Movie?> {
  SetCurrentMovie(Movie? movie) : super(content: movie);
}

/// Action to unload [AppState]'s current [Movie]
class UnloadMovieAction extends Action {}
