import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/components/loading.dart';
import 'package:venda_sys/models/produto.dart';
import 'package:venda_sys/screens/produtos/form.dart';

class ProdutosList extends StatelessWidget {
  const ProdutosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<ProdutosBloc>().search();

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<ProdutosBloc>().outProdutos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Produto> produtos = snapshot.data! as List<Produto>;

            return ListView.builder(
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _listTile(int index, Produto produto, BuildContext context) {
    return Card(
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
          },
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colors.red,
            child: Padding(
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
                Text(produto.codigo),
              ],
            ),
            title: Text(
              produto.descricao,
              maxLines: 1,
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Valor Compra: R\$ ${_corrigeValor(produto.valorCompra)}'),
                SizedBox(
                  width: 8,
                ),
                Text('Valor Venda: R\$ ${_corrigeValor(produto.valorVenda)}'),
              ],
            ),
            trailing: Text('${_corrigeValor(produto.estoque)}'),
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
            content: Text("Tem certeza que deseja remover esse produto?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Cancelar",
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                child: Text(
                  "Remover",
                ),
                onPressed: () async {
                  bool _removed = await BlocProvider.getBloc<ProdutosBloc>().delete(produto.id);
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
}
