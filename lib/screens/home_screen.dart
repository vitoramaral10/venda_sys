import 'package:flutter/material.dart';
import 'package:venda_sys/components/base_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      currentScreen: '',
      child: Row(
        children: const [],
      ),
    );
  }
}
