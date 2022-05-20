import 'package:flutter/material.dart';
import 'package:venda_sys/functions/import_xml.dart';

import 'widgets/base_widget.dart';
import 'widgets/dashboard_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        title: 'Início',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardButton(
              icon: Icons.import_export,
              title: 'Importar XML',
              onTap: () {
                ImportXml.importPopup(context);
              },
            ),
          ],
        ));
  }
}
