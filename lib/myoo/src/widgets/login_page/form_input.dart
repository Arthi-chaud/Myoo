import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:myoo/myoo/src/theme_data.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    Key? key,
    required this.name,
    required this.title,
    this.isPassword = false,
    this.validators = const []
  }) : super(key: key);

  /// ID of the input in parent form
  final String name;

  /// Description of field for user
  final String title;

  /// Is the Field's value something to obscure?
  final bool isPassword;

  /// Field validators.
  /// A [FormInput] value is required by default
  final List<String? Function(String?)> validators;

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FormBuilderTextField(
        name: name,
        obscureText: isPassword,
        style: TextStyle(
          color: getColorScheme(context).onPrimary
        ),
        cursorColor: getColorScheme(context).onPrimary,
        decoration: InputDecoration(
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          label: Text(
            title,
            style: const TextStyle(
              color: Colors.grey
            )
          ),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          ...validators
        ],
      )
    )
  );
}
