import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/components/drawe_list_tile.dart';
import 'package:venda_sys/config/theme.dart';
import 'package:venda_sys/models/usuario.dart';

import '../libraries/constants.dart';
import '../libraries/responsive.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario>(
        future: BlocProvider.getBloc<LoginBloc>().checkLogged(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          Usuario usuario = snapshot.data!;

          return Drawer(
            backgroundColor: myTheme.primaryColor,
            child: ListView(
              children: [
                !Responsive.isDesktop(context)
                    ? UserAccountsDrawerHeader(
                        accountName: Text(usuario.nome),
                        accountEmail: Text(usuario.email),
                        currentAccountPicture: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(usuario.imagem),
                          backgroundColor: Colors.transparent,
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                const DrawerListTile(
                  title: 'Início',
                  icon: Icons.dashboard_outlined,
                  route: '/home',
                ),
                const ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.inbox,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Produtos',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      DrawerListTile(
                        title: 'Produtos',
                        route: '/produtos',
                      ),
                      DrawerListTile(
                        title: 'Unidades de Medida',
                        route: '/unidades_medida',
                      ),
                    ]),
                const DrawerListTile(
                  title: 'Clientes',
                  icon: Icons.business_sharp,
                  route: '/clientes',
                ),
                const DrawerListTile(
                  title: 'Fiscal',
                  icon: Icons.receipt_long,
                  route: '/fiscal',
                ),
                const ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Configurações',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      DrawerListTile(
                        title: 'Usuários',
                        route: '/usuarios',
                      ),
                    ]),
                DrawerListTile(
                  title: 'Sair',
                  icon: Icons.exit_to_app,
                  route: '/logout',
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
                ),
              ],
            ),
          );
        });
  }
}
