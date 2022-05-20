import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/libraries/constants.dart';
import 'package:venda_sys/models/usuario.dart';

import '../../libraries/responsive.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario>(
        future: BlocProvider.getBloc<LoginBloc>().checkLogged(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          Usuario usuario = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(left: Constants.defaultPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.defaultPadding,
              vertical: Constants.defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Constants.secondary,
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
                if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding / 2),
                    child: Text(
                      usuario.nome,
                      style: const TextStyle(color: Colors.white),
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
        });
  }
}
