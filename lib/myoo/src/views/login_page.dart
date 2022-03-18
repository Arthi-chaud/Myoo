import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/login/login_form.dart';

/// Form Page to Connect a [KyooClient] and add it to [AppState]
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoginForm()),
    );
  }
}
