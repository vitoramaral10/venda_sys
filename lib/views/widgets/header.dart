import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/auth_controller.dart';
import 'package:venda_sys/libraries/utils.dart';

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
              onTap: () async {
                try {
                  await controller.logout();
                } catch (e) {
                  Utils.dialog();
                }
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
                    style: Get.textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
