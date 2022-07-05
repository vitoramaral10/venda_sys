import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/views/widgets/drawer_expansion_tile.dart';
import 'package:venda_sys/views/widgets/drawer_tile.dart';

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
                color: Constants.primaryColor,
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
            ),
            Expanded(
              flex: Constants.flex2,
              child: ListView(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                children: [
                  DrawerTile(
                    icon: FontAwesomeIcons.house,
                    title: 'home'.tr,
                    route: '/home',
                  ),
                  DrawerExpansionTile(
                    icon: FontAwesomeIcons.inbox,
                    title: 'products'.tr,
                    children: [
                      DrawerTile(
                        title: 'products'.tr,
                        route: '/products/products',
                      ),
                      DrawerTile(
                        title: 'units_of_measurement'.tr,
                        route: '/products/units_of_measurement',
                      ),
                    ],
                  ),
                  DrawerTile(
                    title: 'clients'.tr,
                    route: '/clients',
                    icon: FontAwesomeIcons.users,
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
