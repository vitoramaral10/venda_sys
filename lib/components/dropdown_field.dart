import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final Map<String, String> items;
  final String value;
  final Function(String? value)? onChanged;

  const DropdownField(
      {Key? key, required this.items, required this.value, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: value,
        items: items.entries
            .map((e) => DropdownMenuItem(
                  child: Text(e.value),
                  value: e.key,
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
