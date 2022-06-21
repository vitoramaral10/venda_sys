import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreadCrumbs extends GetView {
  const BreadCrumbs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> routeParts = Get.currentRoute.split('/');
    List<Widget> breadCrumbs = [];

    for (int i = 0; i < routeParts.length; i++) {
      if (i == routeParts.length - 1) {
        breadCrumbs.add(Text(
          routeParts[i].tr,
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ));
      } else if (i > 0) {
        breadCrumbs.add(Text(
          routeParts[i].tr,
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ));
        breadCrumbs.add(Text(
          ' > ',
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ));
      }
    }

    return Row(
      children: breadCrumbs,
    );
  }
}
