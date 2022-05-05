import 'package:flutter/material.dart';
import 'package:venda_sys/libraries/constants.dart';

class CarregandoWidget extends StatelessWidget {
  const CarregandoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Constants.primary,
          ),
          SizedBox(height: 15),
          Text("Carregando..."),
        ],
      ),
    );
  }
}
