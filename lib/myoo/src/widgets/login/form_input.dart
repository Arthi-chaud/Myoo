import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    Key? key,
    required this.name,
    required this.title,
    required this.icon,
    this.validators = const []
  }) : super(key: key);

  /// ID of the input in parent form
  final String name;

  /// Description of field for user
  final String title;

  /// Leading icon in field
  final Icon icon;

  /// Field validators.
  /// A [FormInput] value is required by default
  final List<String? Function(String?)> validators;

  @override
  Widget build(BuildContext context) =>
    FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        helperText: title,
        icon: icon
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context),
        ...validators
      ],
    )
  );
}