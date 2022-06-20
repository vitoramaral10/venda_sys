import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../config/themes/light.dart';
import 'drawer_expansion_tile.dart';
import 'drawer_tile.dart';

class SideMenu extends GetView {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: appLinkTxtColor,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFDEE2E6),
                    width: 1,
                  ),
                ),
              ),
              height: AppBar().preferredSize.height + 1,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
                vertical: 5,
              ),
              child: Image.asset(
                "assets/logos/logo_yellow_horizontal.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                children: [
                  DrawerExpansionTile(
                    icon: FontAwesomeIcons.gear,
                    title: "administration".tr,
                    isSelected: Get.currentRoute.contains('/administration')
                        ? true
                        : false,
                    children: <Widget>[
                      DrawerTile(
                        title: 'users'.tr,
                        route: '/administration/users',
                      ),
                      DrawerTile(
                        title: 'permissions'.tr,
                        route: '/administration/permissions',
                      ),
                      DrawerTile(
                        title: 'services'.tr,
                        route: '/administration/services',
                      ),
                    ],
                  ),
                  DrawerExpansionTile(
                    icon: FontAwesomeIcons.sliders,
                    title: "parameters".tr,
                    isSelected:
                        Get.currentRoute.contains('/parameters') ? true : false,
                    children: <Widget>[
                      DrawerTile(
                        title: 'fees_and_taxes'.tr,
                        route: '/parameters/fees_and_taxes',
                      ),
                      DrawerTile(
                        title: 'billing'.tr,
                        route: '/parameters/billing',
                      ),
                      DrawerTile(
                        title: 'workflow'.tr,
                        route: '/parameters/workflow',
                      ),
                    ],
                  ),
                  DrawerExpansionTile(
                    icon: FontAwesomeIcons.userGear,
                    title: "backoffice".tr,
                    isSelected:
                        Get.currentRoute.contains('/backoffice') ? true : false,
                    children: <Widget>[
                      DrawerTile(
                        title: 'bearers'.tr,
                        route: '/backoffice/bearers',
                      ),
                      DrawerTile(
                        title: 'workflow_queues'.tr,
                        route: '/backoffice/workflow_queues',
                      ),
                      DrawerTile(
                        title: 'financial_adjustments'.tr,
                        route: '/backoffice/financial_adjustments',
                      ),
                      DrawerTile(
                        title: 'refinancing'.tr,
                        route: "/backoffice/refinancing",
                      ),
                    ],
                  ),
                  DrawerTile(
                    icon: FontAwesomeIcons.headset,
                    title: "support".tr,
                    route: "/helpdesk",
                  ),
                  DrawerExpansionTile(
                    icon: FontAwesomeIcons.solidComments,
                    title: "attendance".tr,
                    isSelected:
                        Get.currentRoute.contains('/attendance') ? true : false,
                    children: <Widget>[
                      DrawerTile(
                        title: 'demands'.tr,
                        route: '/attendance/demands',
                      ),
                      DrawerTile(
                        title: 'bearers'.tr,
                        route: '/attendance/bearers',
                      ),
                    ],
                  ),
                  DrawerTile(
                    icon: FontAwesomeIcons.chartPie,
                    title: "reports".tr,
                    route: "/reports",
                  ),
                  DrawerTile(
                    icon: FontAwesomeIcons.solidFile,
                    title: "manuals".tr,
                    route: "/manuals",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
