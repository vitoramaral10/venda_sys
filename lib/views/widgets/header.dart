import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../config/constants.dart';
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
              child: ListTile(
                leading: const Icon(FontAwesomeIcons.doorOpen),
                title: Text('exit'.tr),
              ),
            ),
          ],
          child: Center(
            child: Row(
              children: [
                const SizedBox(
                  width: Constants.defaultPadding,
                ),
                Obx(
                  () => Text(
                    controller.userName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,),
                  ),
                ),
                const SizedBox(
                  width: Constants.defaultPadding,
                ),
                const Icon(
                  FontAwesomeIcons.angleDown,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: Constants.defaultPadding,
        ),
      ],
    );
  }
}
