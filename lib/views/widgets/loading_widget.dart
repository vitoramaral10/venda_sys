import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends GetView {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 15),
          Text("Carregando..."),
        ],
      ),
    );
  }
}
