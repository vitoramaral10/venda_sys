import 'package:flutter/material.dart';
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosList()));
                    }),
                _menuTile(
                    title: 'Unidades de Medida',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnidadesMedidaList()));
                    }),
              ]),
          _menuTile(title: 'Clientes', onTap: () {}, icon: Icons.business_sharp),
          _menuTile(title: 'Fiscal', onTap: () {}, icon: Icons.receipt_long),
        ],
      ),
    );
  }
}

Widget _menuTile({required String title, required void Function() onTap, IconData? icon}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      leading: icon != null ? Icon(icon) : null,
      dense: true,
      title: Text(title),
    ),
  );
}
