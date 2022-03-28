import 'package:myoo/myoo/src/actions/action.dart';

/// Parameters of the [Navigator] related actions
class NavigationActionContent {
  final String routeName;
  final void Function()? onPop;

  const NavigationActionContent({required this.routeName, this.onPop});
}

/// Action to push named route
class NavigatorPushAction extends ContainerAction<NavigationActionContent> {
  NavigatorPushAction(String routeName, {void Function()? onPop}) :
    super(content: NavigationActionContent(routeName: routeName, onPop: onPop));
}

/// Action to push named route, and pop current route
class NavigatorPopAndPushAction extends ContainerAction<NavigationActionContent> {
  NavigatorPopAndPushAction(String routeName, {void Function()? onPop}) :
    super(content: NavigationActionContent(routeName: routeName, onPop: onPop));
}

/// Action to pop route
class NavigatorPopAction extends Action {}
