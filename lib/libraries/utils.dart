import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';

class Utils {
  static void loading() {
    dialog(
      title: "loading".tr,
      content: const Center(
        child: CircularProgressIndicator(),
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
    title = (title == null) ? 'Oops' : title;
    content = (content == null)
        ? const Text('Ocorreu um erro, por favor tente novamente.')
        : content;

    Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      radius: Constants.radius,
      contentPadding: const EdgeInsets.all(Constants.defaultPadding),
      titlePadding: const EdgeInsets.all(Constants.defaultPadding),
      title: title,
      titleStyle: Get.textTheme.headline2,
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
        ? 'Ok'
        : actionParams['confirmText'];
    String cancelText = (actionParams['cancelText'] == null)
        ? 'Cancelar'
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
