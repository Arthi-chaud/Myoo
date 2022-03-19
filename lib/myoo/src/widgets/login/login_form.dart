import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myoo/myoo/src/widgets/login/form_button.dart';
import 'package:myoo/myoo/src/widgets/login/form_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FormInput(
              name: 'server',
              title: 'Server URL',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50, vertical: 10
              ),
              child: Divider(
                thickness: 0,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const FormInput(
              name: 'username',
              title: 'User name',
            ),
            const FormInput(
              name: 'password',
              title: 'Password',
              isPassword: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
              child: FormButton(
                label: 'Login',
                onPressed: () => print("")
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: FormButton(
                label: 'Register',
                onPressed: () => print("")
              ),
            ),
         ],
        ),
      )
    );
  }
}
