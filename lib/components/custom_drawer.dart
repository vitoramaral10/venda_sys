import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/models/usuario.dart';
import 'package:venda_sys/screens/fiscal/list.dart';
import 'package:venda_sys/screens/home_screen.dart';
import 'package:venda_sys/screens/login_screen.dart';
import 'package:venda_sys/screens/produtos/list.dart';
import 'package:venda_sys/screens/unidades_medida/list.dart';
import 'package:venda_sys/screens/usuarios/list.dart';

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
                UserAccountsDrawerHeader(
                  accountName: Text(_usuario.nome),
                  accountEmail: Text(_usuario.email),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(_usuario.imagem),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                _menuTile(
                    title: 'Início',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    },
                    icon: Icons.dashboard_outlined),
                ExpansionTile(
                    leading: const Icon(
                      Icons.inbox,
                      color: Colors.black,
                    ),
                    title:
                        const Text('Produtos', style: TextStyle(fontSize: 16)),
                    children: [
                      _menuTile(
                        title: 'Produtos',
                        onTap: () {
                          _navigation(
                              context, const ProdutosList(), '/produtos');
                        },
                      ),
                      _menuTile(
                          title: 'Unidades de Medida',
                          onTap: () {
                            _navigation(context, const UnidadesMedidaList(),
                                '/unidades_medida');
                          }),
                    ]),
                _menuTile(
                  title: 'Clientes',
                  icon: Icons.business_sharp,
                  trailing: const Chip(
                    label: Text(
                      'Em breve',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                ),
                _menuTile(
                  title: 'Fiscal',
                  icon: Icons.receipt_long,
                  onTap: () {
                    _navigation(context, FiscalList(), '/fiscal');
                  },
                ),
                ExpansionTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    title: const Text('Configurações',
                        style: TextStyle(fontSize: 16)),
                    children: [
                      _menuTile(
                        title: 'Usuários',
                        onTap: () {
                          _navigation(
                              context, const UsuariosList(), '/usuarios');
                        },
                      ),
                    ]),
                _menuTile(
                    title: 'Sair',
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
                    icon: Icons.exit_to_app),
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
              color: Colors.black,
            )
          : null,
      dense: true,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: trailing,
    ),
  );
}

_navigation(BuildContext context, Widget widget, String route) {
  Navigator.pushNamed(context, route);
}
