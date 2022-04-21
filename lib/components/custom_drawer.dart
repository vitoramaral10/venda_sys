import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/components/drawe_list_tile.dart';
import 'package:venda_sys/models/usuario.dart';
import 'package:venda_sys/screens/login_screen.dart';

import '../libraries/constants.dart';
import '../libraries/responsive.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario>(
        future: BlocProvider.getBloc<LoginBloc>().checkLogged(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          Usuario _usuario = snapshot.data!;

          return Drawer(
            child: ListView(
              children: [
                !Responsive.isDesktop(context)
                    ? UserAccountsDrawerHeader(
                        accountName: Text(_usuario.nome),
                        accountEmail: Text(_usuario.email),
                        currentAccountPicture: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(_usuario.imagem),
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Constants.defaultPadding,
                          vertical: Constants.defaultPadding * 2,
                        ),
                        child: const Center(
                          child: Text(
                            'VendaSys',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
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

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
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

Widget _menuTile(
    {required String title,
    void Function()? onTap,
    IconData? icon,
    Widget? trailing}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: Colors.white,
            )
          : null,
      dense: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      trailing: trailing,
    ),
  );
}

_navigation(BuildContext context, Widget widget, String route) {
  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
}
