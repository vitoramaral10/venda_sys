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
          _menuTile(
              title: 'Produtos',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosList()));
              }),
          ExpansionTile(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 16,
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
                    title: 'Unidades de Medida',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnidadesMedidaList()));
                    }),
              ]),
        ],
      ),
    );
  }
}

Widget _menuTile({required String title, required void Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      title: Text(title),
    ),
  );
}
