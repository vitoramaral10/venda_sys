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
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder<Usuario>(
              future: BlocProvider.getBloc<LoginBloc>().checkLogged(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                Usuario _usuario = snapshot.data!;

                return UserAccountsDrawerHeader(
                  accountName: Text(_usuario.nome),
                  accountEmail: Text(_usuario.email),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(_usuario.imagem),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }),
          _menuTile(
              title: 'Início',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
              },
              icon: Icons.dashboard_outlined),
          ExpansionTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.inbox,
                    size: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Produtos',
                  ),
                ],
              ),
              children: [
                _menuTile(
                  title: 'Produtos',
                  onTap: () {
                    _navigation(context, const ProdutosList());
                  },
                ),
                _menuTile(
                    title: 'Unidades de Medida',
                    onTap: () {
                      _navigation(context, const UnidadesMedidaList());
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
              _navigation(context, FiscalList());
            },
          ),
          ExpansionTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Configurações',
                  ),
                ],
              ),
              children: [
                _menuTile(
                  title: 'Usuários',
                  onTap: () {
                    _navigation(context, const UsuariosList());
                  },
                ),
              ]),
          _menuTile(
              title: 'Sair',
              onTap: () async {
                try {
                  await BlocProvider.getBloc<LoginBloc>().signOut();

                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                } catch (e) {
                  throw Exception(e);
                }
              },
              icon: Icons.exit_to_app),
        ],
      ),
    );
  }
}

Widget _menuTile({required String title, void Function()? onTap, IconData? icon, Widget? trailing}) {
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
      title: Text(title),
      trailing: trailing,
    ),
  );
}

_navigation(BuildContext context, Widget widget) {
  Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
