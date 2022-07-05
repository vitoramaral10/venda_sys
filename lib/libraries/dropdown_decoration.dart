import 'package:flutter/material.dart';
import 'package:venda_sys/config/constants.dart';

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
        borderRadius: BorderRadius.circular(Constants.middlePadding),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.middlePadding),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.middlePadding),
      ),
    );
  }
}
