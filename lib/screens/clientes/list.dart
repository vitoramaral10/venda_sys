import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/clientes_bloc.dart';
import 'package:venda_sys/models/cliente/cliente.dart';
import 'package:venda_sys/screens/widgets/base_widget.dart';

import 'view.dart';

class ClientesList extends StatelessWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<ClientesBloc>().search();

    return BaseWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/clientes/novo');
        },
        child: const Icon(Icons.add),
      ),
      title: 'Clientes',
      child: StreamBuilder<List<Cliente>>(
        stream: BlocProvider.getBloc<ClientesBloc>().outClientes,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Cliente> clientes = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                return _listTile(index, clientes[index], context);
              },
            );
          }
        },
      ),
    );
  }

  Widget _listTile(int index, Cliente cliente, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClientesView(
                cliente: cliente,
              ),
            ),
          );
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
              UtilBrasilFields.obterCnpj(cliente.cnpj.toString()),
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
                  bool removed = await BlocProvider.getBloc<ClientesBloc>()
                      .delete(cliente.id);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop(removed);
                },
              ),
            ],
          );
        });
  }
}
