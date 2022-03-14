import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/kyoo_api/src/models/ressource_preview.dart';

/// A [Server] is a running instance of Kyoo
class Server {
  /// URL of the server, without '/api' prefix
  String url;
  /// [Library] list of the current [Server]
  List<Library> libraries;
  /// Pool of [RessourcePreview]s contained in the server
  /// All ressources from all the libraries are accessible from here
  List<RessourcePreview> items;

}
