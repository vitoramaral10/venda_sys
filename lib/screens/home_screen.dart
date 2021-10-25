import 'package:flutter/material.dart';
import 'package:venda_sys/components/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Início'),
      ),
      drawer: CustomDrawer(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 3),
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.archive), Text('asdas')],
            ),
          ),
        ],
      ),
    );
  }
}
