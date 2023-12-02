import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  const MyTextInput({
    super.key,
    required this.controller,
    required this.validator,
    this.label,
    this.hint,
    this.icon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final Icon? icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
      ),
    );
  }
}
