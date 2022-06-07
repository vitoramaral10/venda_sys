import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/functions/import_xml.dart';

import 'widgets/base_widget.dart';
import 'widgets/dashboard_button.dart';

class HomePage extends GetView {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
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
