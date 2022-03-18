import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/components/base_widget.dart';
import 'package:venda_sys/models/produto.dart';

import 'form.dart';

class ProdutosList extends StatelessWidget {
  const ProdutosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: FutureBuilder(
        future: BlocProvider.getBloc<ProdutosBloc>().search(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Produto> produtos = snapshot.data! as List<Produto>;

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return _listTile(index, produtos[index], context);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProdutosForm()));
        },
        child: const Icon(Icons.add),
      ),
      currentScreen: '',
    );
  }

  Widget _listTile(int index, Produto produto, BuildContext context) {
    return Card(
      color: produto.estoque < 0 ? Colors.redAccent : Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProdutosForm(
                        id: produto.id,
                      )));
        },
        child: Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              final bool res = await _removePopup(context, produto);

              return res;
            }
            return null;
          },
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  produto.codigo,
                  style: TextStyle(
                    color: produto.estoque < 0 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            title: Text(
              produto.descricao,
              maxLines: 1,
              style: TextStyle(
                color: produto.estoque < 0 ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valor Compra: R\$ ${_corrigeValor(produto.valorCompra.toStringAsFixed(2))}',
                  style: TextStyle(
                    color: produto.estoque < 0 ? Colors.white : Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Valor Venda: R\$ ${_corrigeValor(produto.valorVenda.toStringAsFixed(2))}',
                  style: TextStyle(
                    color: produto.estoque < 0 ? Colors.white : Colors.black54,
                  ),
                ),
              ],
            ),
            trailing: Text(
              _checkInteger(produto.estoque)
                  ? produto.estoque.toInt().toString()
                  : produto.estoque.toString(),
              style: TextStyle(
                color: produto.estoque < 0 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _removePopup(BuildContext context, Produto produto) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Tem certeza que deseja remover esse produto?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancelar",
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                child: const Text(
                  "Remover",
                ),
                onPressed: () async {
                  bool _removed = await BlocProvider.getBloc<ProdutosBloc>()
                      .delete(produto.id);
                  Navigator.of(context).pop(_removed);
                },
              ),
            ],
          );
        });
  }

  String _corrigeValor(dynamic valor) {
    return (valor != null) ? valor.toString() : '-';
  }

  _checkInteger(double value) => (value % 1) == 0;
}
