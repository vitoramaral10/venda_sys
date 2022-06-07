import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/models/user.dart';

import '../../controllers/users_controller.dart';
import '../widgets/custom_text_field.dart';

// ignore: must_be_immutable
class UsersForm extends GetView<UsersController> {
  String id;

  UsersForm({
    Key? key,
    this.id = '',
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();

  User? user;

  // _loadData() async {
  //   user = await BlocProvider.getBloc<UsersBloc>().getUser(widget.id);

  //   if (user!.id.isNotEmpty) {
  //     _nomeController.text = user!.nome;

  //     setState(() {});
  //   } else if (widget.id.isNotEmpty) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //     errorPopup(
  //         title: 'Erro ao abrir o cadastro do usuário',
  //         text:
  //             'Não foi possível abrir esse, se persistir entre em contato com o desenvolvedor');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${(id.isNotEmpty) ? 'Editar' : 'Nova'} Unidade de Medida',
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
                      final userFinal = User(
                        id,
                        _nomeController.text,
                        user!.email,
                        user!.imagem,
                        user!.empresas,
                      );

                      (id.isEmpty) ? _save(userFinal) : _edit(userFinal);
                    }
                  },
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }

  void _save(User user) {
    // BlocProvider.getBloc<UsersBloc>().save(user).then((e) {
    //   if (e == true) {
    //     Navigator.pop(context);
    //   } else {
    //     errorPopup(
    //       text: 'Ocorreu um erro ao salvar, tente novamente!',
    //       title: 'Erro ao salvar',
    //     );
    //   }
    // });
  }

  void _edit(User user) {
    // BlocProvider.getBloc<UsersBloc>().edit(user).then((e) {
    //   if (e == true) {
    //     Util.navigation(context, const UsersPage());
    //   } else {
    //     errorPopup(
    //       text: 'Ocorreu um erro ao editar, tente novamente!',
    //       title: 'Erro ao editar',
    //     );
    //   }
    // });
  }
}
