import 'package:myoo/myoo/src/actions/action.dart';
import 'package:myoo/myoo/src/actions/library_actions.dart';
import 'package:myoo/myoo/src/models/library_content.dart';
import 'package:redux/redux.dart';

final currentLibraryReducers = combineReducers<LibraryContent?>([
  TypedReducer<LibraryContent?, SetCurrentLibraryAction>(setLibrary),
  TypedReducer<LibraryContent?, UnsetCurrentLibraryAction>((_, __) => null),
  TypedReducer<LibraryContent?, LoadedContentFromLibraryAction>(setItems),
  TypedReducer<LibraryContent?, LibraryIsFullAction>(setLibraryAsFull),
]);

LibraryContent? setLibrary(LibraryContent? old, ContainerAction<LibraryContent> action) => action.content;

LibraryContent? setLibraryAsFull(LibraryContent? old, action) =>
  LibraryContent(fullyLoaded: true, content: old!.content, library: old.library);

LibraryContent? setItems(LibraryContent? old, LoadedContentFromLibraryAction action) =>
  LibraryContent(
    fullyLoaded: old!.fullyLoaded,
    content: List.from(old.content)..addAll(action.content),
    library: old.library
  );
