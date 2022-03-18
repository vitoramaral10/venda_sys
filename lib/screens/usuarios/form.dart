import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/usuarios_bloc.dart';
import 'package:venda_sys/components/custom_text_field.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/usuario.dart';

import '../../libraries/util.dart';
import 'list.dart';

// ignore: must_be_immutable
class UsuariosForm extends StatefulWidget {
  String id;

  UsuariosForm({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  _UsuariosFormState createState() => _UsuariosFormState();
}

class _UsuariosFormState extends State<UsuariosForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();

  Usuario? usuario;

  @override
  initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    usuario = await BlocProvider.getBloc<UsuariosBloc>().getUsuario(widget.id);

    if (usuario!.id.isNotEmpty) {
      _nomeController.text = usuario!.nome;

      setState(() {});
    } else if (widget.id.isNotEmpty) {
      Navigator.pop(context);
      errorPopup(
          context: context,
          title: 'Erro ao abrir o cadastro do usuário',
          text:
              'Não foi possível abrir esse, se persistir entre em contato com o desenvolvedor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ((widget.id.isNotEmpty) ? 'Editar' : 'Nova') + ' Unidade de Medida',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomTextField(
                label: 'Nome',
                controller: _nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                  return null;
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final _usuario = Usuario(
                        widget.id,
                        _nomeController.text,
                        usuario!.email,
                        usuario!.imagem,
                        usuario!.empresas,
                      );

                      (widget.id.isEmpty) ? _save(_usuario) : _edit(_usuario);
                    }
                  },
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }

  void _save(Usuario usuario) {
    BlocProvider.getBloc<UsuariosBloc>().save(usuario).then((e) {
      if (e == true) {
        Navigator.pop(context);
      } else {
        errorPopup(
          context: context,
          text: 'Ocorreu um erro ao salvar, tente novamente!',
          title: 'Erro ao salvar',
        );
      }
    });
  }

  void _edit(Usuario usuario) {
    BlocProvider.getBloc<UsuariosBloc>().edit(usuario).then((e) {
      if (e == true) {
        Util.navigation(context, const UsuariosList());
      } else {
        errorPopup(
          context: context,
          text: 'Ocorreu um erro ao editar, tente novamente!',
          title: 'Erro ao editar',
        );
      }
    });
  }
}
