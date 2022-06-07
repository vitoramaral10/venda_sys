import 'dart:convert';

import 'package:excel_to_json/excel_to_json.dart';
import 'package:flutter/material.dart';

class ProdutosImport extends StatefulWidget {
  const ProdutosImport({Key? key}) : super(key: key);

  @override
  State<ProdutosImport> createState() => _ProdutosImportState();
}

class _ProdutosImportState extends State<ProdutosImport> {
  int countInicial = 0;
  int countFinal = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar produtos'),
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

                    // for (var produtoExcel in list) {
                      // Product produto = Product.fromJson(produtoExcel);

                      // List<Product> produtosEncontrados =
                      //     await BlocProvider.getBloc<ProdutosBloc>().searchBy(produto.codigo);

                      // if (produtosEncontrados.isEmpty) {
                      //   UnidadeMedida unidadeMedida =
                      //       await BlocProvider.getBloc<UnidadesMedidaBloc>().searchBy('descricao', produto.un);

                      //   produto.un = unidadeMedida.id;

                      //   bool saved = await BlocProvider.getBloc<ProdutosBloc>().save(produto);

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
                    child: Text('Produtos importados:'),
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
