import 'package:flutter/material.dart';
import 'package:venda_sys/config/constants.dart';

class DropdownField extends StatelessWidget {
  final Map<String, String> items;
  final String value;
  final Function(String? value)? onChanged;

  const DropdownField(
      {Key? key, required this.items, required this.value, this.onChanged,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.buttonHeight,
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: value,
        items: items.entries
            .map((e) => DropdownMenuItem(
                  value: e.key,
                  child: Text(e.value),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
