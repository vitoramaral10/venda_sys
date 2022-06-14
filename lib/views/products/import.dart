import 'dart:convert';

import 'package:excel_to_json/excel_to_json.dart';
import 'package:flutter/material.dart';

class ProductsImport extends StatefulWidget {
  const ProductsImport({Key? key}) : super(key: key);

  @override
  State<ProductsImport> createState() => _ProductsImportState();
}

class _ProductsImportState extends State<ProductsImport> {
  int countInicial = 0;
  int countFinal = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar products'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  countInicial = 0;
                  countFinal = 0;
                  loading = true;
                  ExcelToJson().convert().then((excel) async {
                    List list = jsonDecode(excel!);
                    setState(() {
                      countInicial = list.length;
                    });

                    // for (var productExcel in list) {
                    // Product product = Product.fromJson(productExcel);

                    // List<Product> productsEncontrados =
                    //     await BlocProvider.getBloc<ProductsBloc>().searchBy(product.codigo);

                    // if (productsEncontrados.isEmpty) {
                    //   UnidadeMedida unidadeMedida =
                    //       await BlocProvider.getBloc<UnidadesMedidaBloc>().searchBy('descricao', product.un);

                    //   product.un = unidadeMedida.id;

                    //   bool saved = await BlocProvider.getBloc<ProductsBloc>().save(product);

                    //   if (saved) {
                    //     setState(() {
                    //       countFinal++;
                    //     });
                    //   }
                    // }
                    // }
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Buscar arquivo'),
                )),
            loading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Products importados:'),
                  )
                : Container(),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$countFinal de $countInicial'),
                  )
                : Container(),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      value: (countInicial / 100) * countFinal - 1,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
