import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
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
                return _listTile(index, produtos, context);
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

  Card _listTile(int index, List<Produto> produto, BuildContext context) {
    return Card(
      child: Dismissible(
        key: ValueKey<int>(index),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            final bool res = await _removePopup(context, produto, index);

            return res;
          } else {
            
            return false;
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
        secondaryBackground: Container(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          color: Colors.blue,
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(produto[index].codigo),
            ],
          ),
          title: Text(
            produto[index].descricao,
            maxLines: 1,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Valor Compra: R\$ ${_corrigeValor(produto[index].valorCompra)}'),
              SizedBox(
                width: 8,
              ),
              Text('Valor Venda: R\$ ${_corrigeValor(produto[index].valorVenda)}'),
            ],
          ),
          trailing: Text('${_corrigeValor(produto[index].estoque)}'),
        ),
      ),
    );
  }

  _removePopup(BuildContext context, List<Produto> produto, int index) async {
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
                  bool _removed = await BlocProvider.getBloc<ProdutosBloc>().delete(produto[index].id);
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
