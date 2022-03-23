import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/widgets/login_page/form_input.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/login_page/form_button.dart';
import 'package:myoo/myoo/src/theme_data.dart';

/// Form Page to Connect a [KyooClient] and add it to [AppState]
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: FormBuilder(
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
                  padding: const EdgeInsets.only(
                    left: 50, right: 50, bottom: 10
                  ),
                  child: Divider(
                    thickness: 0,
                    color: getColorScheme(context).surface,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: FormButton(
                    label: 'Connect',
                    onPressed: () {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        StoreProvider.of<AppState>(context).dispatch(
                            NewClientConnectedAction(
                              KyooClient(
                                serverURL: _formKey.currentState!.value['server'],
                              )
                            )
                        );
                        Navigator.of(context).popAndPushNamed('/list');
                      }
                    }
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}
