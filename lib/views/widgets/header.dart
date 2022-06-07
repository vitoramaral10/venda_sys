import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../config/themes/light.dart';
import '../../controllers/auth_controller.dart';

// ignore: must_be_immutable
class Header extends GetView<AuthController> {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: GetPlatform.isDesktop ? false : true,
      actions: [
        PopupMenuButton(
          offset: const Offset(-16, 50),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {
                controller.logout();
              },
              child: const ListTile(
                leading: Icon(FontAwesomeIcons.doorOpen),
                title: Text('Sair'),
              ),
            ),
          ],
          child: Center(
            child: Row(
              children: const [
                CircleAvatar(
                  backgroundColor: appLinkTxtColor,
                  foregroundImage: NetworkImage(
                    'https://igd-wp-uploads-pluginaws.s3.amazonaws.com/wp-content/uploads/2016/05/30105213/Qual-e%CC%81-o-Perfil-do-Empreendedor.jpg',
                  ),
                ),
                SizedBox(
                  width: Constants.defaultPadding,
                ),
                Text(
                  'Vitor Melo',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  width: Constants.defaultPadding,
                ),
                Icon(
                  FontAwesomeIcons.angleDown,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: Constants.defaultPadding,
        )
      ],
    );
  }
}
