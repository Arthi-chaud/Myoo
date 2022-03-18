import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myoo/myoo/src/widgets/login/form_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FormInput(
            name: 'server',
            title: 'Server URL',
            icon: Icon(Icons.language),
          ),
          FormInput(
            name: 'username',
            title: 'User name',
            icon: Icon(Icons.account_circle),
          ),
          FormInput(
            name: 'password',
            title: 'Password',
            icon: Icon(Icons.key),
          ),
        ],
      ),
    );
  }
}
