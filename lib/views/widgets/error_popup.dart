import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorPopup({required String title, required String text}) {
  Get.defaultDialog(
    title: title,
    content: Text(text),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("OK")),
    ],
  );
}
