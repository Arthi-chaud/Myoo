import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/loading_widget.dart';

/// 'Lobby' Page while initiating [AppState]
class InitializationPage extends StatelessWidget {
  const InitializationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadingWidget());
  }
}
