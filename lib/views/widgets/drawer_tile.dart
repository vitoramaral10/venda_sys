import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../config/themes/light.dart';

class DrawerTile extends GetView {
  final String title;
  final String route;

  final IconData? icon;

  const DrawerTile(
      {Key? key, required this.title, required this.route, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Get.currentRoute != route) Get.toNamed(route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Get.currentRoute == route
              ? lightTheme.primaryColor
              : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              Constants.defaultPadding / 2,
            ),
          ),
        ),
        child: ListTile(
            leading: icon != null
                ? Icon(
                    icon,
                    size: 20,
                    color: Get.currentRoute == route
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromRGBO(0, 0, 0, 0.7),
                  )
                : null,
            title: Text(
              title,
              style: TextStyle(
                color: Get.currentRoute == route
                    ? Colors.white
                    : const Color.fromRGBO(0, 0, 0, 0.7),
              ),
            )),
      ),
    );
  }
}
