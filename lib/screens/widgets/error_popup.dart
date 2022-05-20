import 'package:flutter/material.dart';

void errorPopup(
    {required BuildContext context,
    required String title,
    required String text}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK")),
          ],
        );
      });
}
