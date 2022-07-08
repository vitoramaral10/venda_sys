import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/config/custom_theme_data.dart';

class DrawerTile extends GetView {
  final String title;
  final String route;
  final IconData? icon;

  const DrawerTile({
    Key? key,
    required this.title,
    required this.route,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(Constants.radius),
        onTap: () =>
            (Get.currentRoute != route) ? Get.offAllNamed(route) : null,
        child: Container(
          decoration: BoxDecoration(
            color: Get.currentRoute == route
                ? CustomThemeData.lightTheme.primaryColor
                : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(Constants.radius),
            ),
          ),
          child: ListTile(
            leading: icon != null
                ? Icon(
                    icon,
                    color: Get.currentRoute == route
                        ? Colors.white
                        : Constants.textColor,
                  )
                : null,
            title: Text(
              title,
              style: Get.textTheme.headline5!.copyWith(
                color: Get.currentRoute == route
                    ? Colors.white
                    : Constants.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
