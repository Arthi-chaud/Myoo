
/// Template class for actions. This is useless basically
abstract class Action {}

/// Template class for actions that hold a value, make development easier
abstract class ContainerAction<T> extends Action {
  /// The value of the action
  T content;

  ContainerAction({required this.content});
}
