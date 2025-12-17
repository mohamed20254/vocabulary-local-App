import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controler;
  final String labelText;

  const CustomTextFormField({
    super.key,
    this.validator,
    required this.controler,
    required this.labelText,
  });

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controler,
      keyboardType: TextInputType.multiline,

      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(
          context,
        ).textTheme.titleSmall!.copyWith(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
