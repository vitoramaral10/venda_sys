import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/usuarios_bloc.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/usuario.dart';

import 'form.dart';

class UsuariosList extends StatelessWidget {
  const UsuariosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<UsuariosBloc>().search();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<UsuariosBloc>().outUsuarios,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Usuario> usuarios = snapshot.data! as List<Usuario>;

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                return _listTile(index, usuarios[index], context);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listTile(int index, Usuario usuario, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UsuariosForm(id: usuario.id)));
        },
        child: Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              try {
                await _removePopup(context, usuario);
                return true;
              } catch (e) {
                errorPopup(
                    context: context,
                    title: 'Erro ao remover o usuário',
                    text: e.toString());
                return false;
              }
            }
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
            title: Text(usuario.nome),
            subtitle: Text(usuario.email),
          ),
        ),
      ),
    );
  }

  _removePopup(BuildContext context, Usuario usuario) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Tem certeza que deseja remover esse usuário?"),
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
                  await BlocProvider.getBloc<UsuariosBloc>().delete(usuario.id);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
