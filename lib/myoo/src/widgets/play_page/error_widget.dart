import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myoo/myoo/myoo_api.dart';

Future showPlayErrorWidget(BuildContext context, String message) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: getColorScheme(context).background,
    builder: (_) {
      return PlayErrorWidget(errorMessage: message);
    }
  );
}

/// Erro widget, displayed in a bottom modal sheet when an error occurs in [PlayScreen]
class PlayErrorWidget extends StatelessWidget {
  /// The message to display
  final String errorMessage;

  const PlayErrorWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Oops...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(errorMessage),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(NavigatorPopAction());
                  StoreProvider.of<AppState>(context).dispatch(NavigatorPopAction());
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Leave"),
                style: ElevatedButton.styleFrom(
                  primary: getColorScheme(context).secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
