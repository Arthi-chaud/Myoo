import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/kyoo_api/src/kyoo_client.dart';
import 'package:myoo/myoo/src/actions/client_actions.dart';
import 'package:myoo/myoo/src/actions/navigation_actions.dart';
import 'package:myoo/myoo/src/widgets/login_page/form_input.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/login_page/form_button.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:redux/redux.dart';

Future showLoginDialog(BuildContext context, {bool disposable = true, bool transparentBarrier = true}) =>
  showAnimatedDialog(
    context: context,
    barrierDismissible: disposable,
    barrierColor: transparentBarrier ? Colors.transparent : getColorScheme(context).background,
    builder: (_) => const LoginDialog(),
    animationType: DialogTransitionType.slideFromBottom,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(seconds: 1),
  );

/// Form Dialog to Connect a [KyooClient] and add it to [AppState]
class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {

  bool? serverExists;
  final formKey = GlobalKey<FormBuilderState>();

  void validateForm(Store<AppState> store) {
    formKey.currentState?.save();
    if (formKey.currentState?.validate() ?? false) {
      if (serverExists == true) {
        KyooClient newClient = KyooClient(
          serverURL: formKey.currentState!.value['server'],
        );
        store.dispatch(NewClientConnectedAction(newClient));
        store.dispatch(NavigatorPopAction());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return AlertDialog(
      backgroundColor: getColorScheme(context).background,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: FormBuilder(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormInput(
                  name: 'server',
                  title: 'Server URL',
                  validators: [
                    (serverURL) {
                      if (serverExists == true) {
                        return null;
                      }
                      if ((store.state.clients?.map((e) => e.serverURL).contains(serverURL) ?? false)) {
                        setState(() => serverExists = null);
                        return 'Server already connected';
                      }
                      KyooClient clientAttempt = KyooClient(serverURL: serverURL!);
                      clientAttempt.getItemsFrom(count: 1).then(
                        (_) => setState(() {
                          serverExists = true;
                          validateForm(store);
                        }),
                      ).catchError((error) {
                        if (mounted) {
                          setState(() {
                            serverExists = false;
                          });
                        }
                      });
                      return null;
                    }
                  ],
                ),
                if (serverExists == false)
                const Text(
                  "Server does not exist",
                  style: TextStyle(color: Colors.red)
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FormButton(
                    label: 'Connect',
                    onPressed: () => validateForm(store)
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
