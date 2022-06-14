import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/controllers/auth_controller.dart';
import 'package:venda_sys/views/widgets/drawer_expansion_tile.dart';

import '../../config/constants.dart';
import '../../config/themes/light.dart';
import 'drawer_tile.dart';

class SideMenu extends GetView<AuthController> {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            !GetPlatform.isDesktop
                ? Obx(
                    () => UserAccountsDrawerHeader(
                      accountName: Text(controller.user.name),
                      accountEmail: Text(controller.user.email),
                      currentAccountPicture: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(controller.user.imagem),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.defaultPadding,
                      vertical: Constants.defaultPadding * 2,
                    ),
                    child: Center(
                      child: Text(
                        'VendaSys',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: appLinkTxtColor,
                        ),
                      ),
                    ),
                  ),
            Expanded(
                flex: 2,
                child: ListView(
                    padding: const EdgeInsets.all(Constants.defaultPadding),
                    children: const [
                      DrawerTile(
                        route: '/home',
                        title: 'Início',
                        icon: FontAwesomeIcons.house,
                      ),
                      DrawerExpansionTile(
                          icon: FontAwesomeIcons.inbox,
                          title: 'Products',
                          children: [
                            DrawerTile(
                              title: 'Products',
                              route: '/products',
                            ),
                            DrawerTile(
                              title: 'Unidades de Medida',
                              route: '/units_of_measure',
                            ),
                          ]),
                      DrawerTile(
                        title: 'Clientes',
                        icon: FontAwesomeIcons.briefcase,
                        route: '/clients',
                      ),
                      DrawerTile(
                        title: 'Fiscal',
                        icon: FontAwesomeIcons.receipt,
                        route: '/invoices',
                      ),
                      DrawerExpansionTile(
                          icon: FontAwesomeIcons.gears,
                          title: 'Configurações',
                          children: [
                            DrawerTile(
                              title: 'Usuários',
                              route: '/users',
                            ),
                          ]),
                    ])),
          ],
        ),
      ),
    );
  }
}
