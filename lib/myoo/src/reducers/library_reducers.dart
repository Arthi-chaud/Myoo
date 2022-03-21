import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/kyoo_api/src/models/library.dart';
import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:redux/redux.dart';

final currentLibraryReducers = combineReducers<Library?>([
  TypedReducer<Library?, SetCurrentLibraryAction>(setLibrary),
  TypedReducer<Library?, UnsetCurrentLibraryAction>((_, __) => null)
]);

Library? setLibrary(Library? old, ContainerAction<Library> action) => action.content;
