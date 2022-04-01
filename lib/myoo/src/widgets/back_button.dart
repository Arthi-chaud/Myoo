
import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Back button to pop current page
class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 25,
      icon: DecoratedIcon(
        Icons.arrow_back,
        color: getColorScheme(context).onBackground,
        shadows: [
          BoxShadow(
            blurRadius: 10.0,
            spreadRadius: 30,
            color: getColorScheme(context).background,
          ),
        ],
      ),
      onPressed: () => StoreProvider.of<AppState>(context).dispatch(NavigatorPopAction())
    );
  }
}
