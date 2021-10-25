import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/screens/fiscal/list.dart';
import 'package:venda_sys/screens/home_screen.dart';
import 'package:venda_sys/screens/login_screen.dart';
import 'package:venda_sys/screens/produtos/list.dart';
import 'package:venda_sys/screens/unidades_medida/list.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://i1.wp.com/terracoeconomico.com.br/wp-content/uploads/2019/01/default-user-image.png?ssl=1'),
              backgroundColor: Colors.transparent,
            ),
          ),
          _menuTile(
              title: 'Início',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
              },
              icon: Icons.dashboard_outlined),
          ExpansionTile(
              title: Row(
                children: [
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
                    _navigation(context, ProdutosList());
                  },
                ),
                _menuTile(
                    title: 'Unidades de Medida',
                    onTap: () {
                      _navigation(context, UnidadesMedidaList());
                    }),
              ]),
          _menuTile(
            title: 'Clientes',
            icon: Icons.business_sharp,
            trailing: Chip(
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
          _menuTile(
              title: 'Sair',
              onTap: () async {
                bool exit = await BlocProvider.getBloc<LoginBloc>().signOut();

                if (exit == true) {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
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
