import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';

class Utils {
  static void loading() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(Constants.defaultPadding),
      titlePadding: const EdgeInsets.all(Constants.defaultPadding),
      radius: Constants.defaultPadding,
      title: "loading".tr,
      content: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Constants.primaryColor),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void dialog({
    String? title,
    Map<String, dynamic>? actionParams,
    Widget? content,
    bool barrierDismissible = true,
  }) {
    title = (title == null) ? 'oops'.tr : title;
    content = (content == null) ? Text('occured_an_error'.tr) : content;

    Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      radius: Constants.defaultPadding,
      contentPadding: const EdgeInsets.all(Constants.defaultPadding),
      titlePadding: const EdgeInsets.all(Constants.defaultPadding),
      title: title,
      content: content,
      actions: (actionParams != null)
          ? _dialogActions(actionParams: actionParams)
          : null,
    );
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

  static List<Widget> _dialogActions({
    required Map<String, dynamic> actionParams,
  }) {
    String confirmText = (actionParams['confirmText'] == null)
        ? 'ok'.tr
        : actionParams['confirmText'];
    String cancelText = (actionParams['cancelText'] == null)
        ? 'cancel'.tr
        : actionParams['cancelText'];

    return [
      if (actionParams['onCancel'] != null)
        TextButton(
          onPressed: actionParams['onCancel'],
          child: Text(cancelText),
        ),
      if (actionParams['onConfirm'] != null)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.smallButtonRadius),
            ),
          ),
          onPressed: actionParams['onConfirm'],
          child: Text(confirmText),
        ),
    ];
  }
}
