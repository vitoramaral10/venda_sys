import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../config/themes/light.dart';

class Utils {
  static void loading() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(Constants.defaultPadding),
      titlePadding: const EdgeInsets.all(Constants.defaultPadding),
      radius: Constants.defaultPadding,
      title: "loading".tr,
      content: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(appLinkTxtColor),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<T?> dialog<T>({
    String? title,
    String? middleText,
    String? confirmText,
    String? cancelText,
    Widget? content,
    bool barrierDismissible = true,
    Function()? onConfirm,
    Function()? onCancel,
    Widget? optionalButton,
  }) async {
    title = (title == null) ? 'oops'.tr : title;
    middleText = (middleText == null) ? 'occured_an_error'.tr : middleText;
    confirmText = (confirmText == null) ? 'ok'.tr : confirmText;
    cancelText = (cancelText == null) ? 'cancel'.tr : cancelText;

    return await Get.defaultDialog(
        barrierDismissible: barrierDismissible,
        radius: Constants.defaultPadding,
        contentPadding: const EdgeInsets.all(Constants.defaultPadding),
        titlePadding: const EdgeInsets.all(Constants.defaultPadding),
        title: title,
        middleText: middleText,
        content: content,
        actions: [
          if (onCancel != null)
            TextButton(
              onPressed: onCancel,
              child: Text(cancelText),
            ),
          if (onConfirm != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Constants.defaultPadding / 3),
                ),
              ),
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
        ]);
  }

  static double? cleanMoney(String value) {
    value = value
        .replaceAll(".", "")
        .replaceAll(",", ".")
        .replaceAll("R", "")
        .replaceAll("\$", "")
        .trim();

    return double.tryParse(value);
  }
}
