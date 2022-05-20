import 'package:flutter/material.dart';

loadingPopup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      });
}
