import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreadCrumbs extends GetView {
  final String? title;
  const BreadCrumbs({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> routeParts = Get.currentRoute.split('/');
    List<Widget> breadCrumbs = [];

    for (int i = 0; i < routeParts.length; i++) {
      if (i == routeParts.length - 1) {
        breadCrumbs.add(Text(
          title ?? routeParts[i].tr,
          style: Get.textTheme.subtitle1,
        ));
      } else if (i > 0) {
        breadCrumbs.add(Text(
          routeParts[i].tr,
          style: Get.textTheme.subtitle1,
        ));
        breadCrumbs.add(Text(
          ' > ',
          style: Get.textTheme.subtitle1,
        ));
      }
    }

    return Row(
      children: breadCrumbs,
    );
  }
}
