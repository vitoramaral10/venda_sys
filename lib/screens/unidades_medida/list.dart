import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/models/unidade_medida.dart';
import 'package:venda_sys/screens/unidades_medida/form.dart';

class UnidadesMedidaList extends StatelessWidget {
  const UnidadesMedidaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<UnidadesMedidaBloc>().search();

    return Scaffold(
      appBar: AppBar(
        title: Text('Unidade de Medida'),
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<UnidadesMedidaBloc>().outUnidadesMedida,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<UnidadeMedida> unidadesMedida = snapshot.data! as List<UnidadeMedida>;

            return ListView.builder(
              itemCount: unidadesMedida.length,
              itemBuilder: (context, index) {
                return _listTile(index, unidadesMedida[index], context);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UnidadesMedidaForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _listTile(int index, UnidadeMedida unidadeMedida, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UnidadesMedidaForm(
                        id: unidadeMedida.id,
                      )));
        },
        child: Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              final bool res = await _removePopup(context, unidadeMedida);

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
                Text(unidadeMedida.sigla),
              ],
            ),
            title: Text(
              unidadeMedida.descricao,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  _removePopup(BuildContext context, UnidadeMedida unidadeMedida) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Tem certeza que deseja remover essa unidade de medida?"),
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
                  bool _removed = await BlocProvider.getBloc<UnidadesMedidaBloc>().delete(unidadeMedida.id);
                  Navigator.of(context).pop(_removed);
                },
              ),
            ],
          );
        });
  }
}