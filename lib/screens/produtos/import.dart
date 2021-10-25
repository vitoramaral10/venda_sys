import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:excel_to_json/excel_to_json.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/models/produto.dart';
import 'package:venda_sys/models/unidade_medida.dart';

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
        title: Text('Importar produtos'),
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
                  ExcelToJson().convert().then((excel) {
                    List list = jsonDecode(excel!);
                    setState(() {
                      countInicial = list.length;
                    });

                    list.forEach((produtoExcel) async {
                      Produto produto = Produto.fromJson(produtoExcel);

                      List<Produto> produtosEncontrados =
                          await BlocProvider.getBloc<ProdutosBloc>().searchBy(produto.codigo);

                      if (produtosEncontrados.length == 0) {
                        UnidadeMedida unidadeMedida =
                            await BlocProvider.getBloc<UnidadesMedidaBloc>().searchBy('descricao', produto.un);

                        produto.un = unidadeMedida.id;

                        bool _saved = await BlocProvider.getBloc<ProdutosBloc>().save(produto);

                        if (_saved) {
                          setState(() {
                            countFinal++;
                          });
                        }
                      }
                    });
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Buscar arquivo'),
                )),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
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
