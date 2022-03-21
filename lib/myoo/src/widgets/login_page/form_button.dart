import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  /// Callback on button press
  final void Function() onPressed;

  /// Button text
  final String label;

  @override
  Widget build(BuildContext context) =>
    SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.secondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10)
            )
          ),
        ),
      )
    );
}
