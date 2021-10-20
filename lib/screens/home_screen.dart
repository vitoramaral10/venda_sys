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
    );
  }
}
