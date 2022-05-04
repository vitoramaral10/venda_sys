import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String label;
  TextEditingController controller;
  String? Function(String?)? validator;
  TextCapitalization textCapitalization;
  TextInputType? keyboardType;
  bool obscureText;
  List<TextInputFormatter>? inputFormatters;
  Function(String)? onChanged;

  CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.textCapitalization = TextCapitalization.characters,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
    );
  }
}
