import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/clientes_bloc.dart';
import 'package:venda_sys/components/base_widget.dart';
import 'package:venda_sys/models/cliente/cliente.dart';

import 'form.dart';

class ClientesList extends StatelessWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<ClientesBloc>().search();

    return BaseWidget(
      child: StreamBuilder(
        stream: BlocProvider.getBloc<ClientesBloc>().outClientes,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Cliente> clientes = snapshot.data! as List<Cliente>;

            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                return _listTile(index, clientes[index], context);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ClientesForm()));
        },
        child: const Icon(Icons.add),
      ),
      title: 'Clientes',
    );
  }

  Widget _listTile(int index, Cliente cliente, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientesForm(
                        id: cliente.id,
                      )));
        },
        child: Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              final bool res = await _removePopup(context, cliente);

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
            title: Text(
              cliente.razaoSocial,
              maxLines: 1,
            ),
            subtitle: Text(
              cliente.cnpj.toString(),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  _removePopup(BuildContext context, Cliente cliente) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Tem certeza que deseja remover esse cliente?"),
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
                  bool _removed = await BlocProvider.getBloc<ClientesBloc>()
                      .delete(cliente.id);
                  Navigator.of(context).pop(_removed);
                },
              ),
            ],
          );
        });
  }
}
