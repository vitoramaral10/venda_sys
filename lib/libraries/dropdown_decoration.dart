import 'package:flutter/material.dart';

class DropdownDecoration {
  static InputDecoration decoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(17.0),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
