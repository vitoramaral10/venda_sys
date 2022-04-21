import 'package:flutter/cupertino.dart';
import 'package:venda_sys/screens/fiscal/list.dart';

import '../screens/home_screen.dart';
import '../screens/produtos/list.dart';
import '../screens/unidades_medida/list.dart';

class Routes {
  static Map<String, WidgetBuilder> list = {
    '/home': (context) => const HomeScreen(),
    '/produtos': (context) => const ProdutosList(),
    '/unidades_medida': (context) => const UnidadesMedidaList(),
    '/fiscal': (context) => FiscalList(),
  };
}
