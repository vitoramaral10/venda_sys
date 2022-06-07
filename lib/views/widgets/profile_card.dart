import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/auth_controller.dart';

class ProfileCard extends GetView<AuthController> {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Constants.defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding,
        vertical: Constants.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                //image: imageProfile!,
                image: Constants.imagemProfileDecorator,
                borderRadius: BorderRadius.circular(50),
              )),
          if (!GetPlatform.isMobile)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding / 2),
              child: Obx(
                () => Text(
                  controller.user.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          PopupMenuButton(
            offset: const Offset(-15, 30),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () async {
                  try {
                    await BlocProvider.getBloc<LoginBloc>().signOut();

                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  } catch (e) {
                    throw Exception(e);
                  }
                },
                child: const ListTile(
                  title: Text('Sair'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
