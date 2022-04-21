import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/clientes_bloc.dart';
import 'package:venda_sys/components/custom_text_field.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/cliente/endereco.dart';

import '../../models/cliente/cliente.dart';

// ignore: must_be_immutable
class ClientesForm extends StatefulWidget {
  String id;

  ClientesForm({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  _ClientesFormState createState() => _ClientesFormState();
}

class _ClientesFormState extends State<ClientesForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _ieController = TextEditingController();
  final TextEditingController _nomeFantasiaController = TextEditingController();

  String unidadeMedida = '';

  Cliente? cliente;

  @override
  initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    cliente = await BlocProvider.getBloc<ClientesBloc>().getCliente(widget.id);

    if (cliente!.id.isNotEmpty) {
      _cnpjController.text = cliente!.cnpj.toString();
      _razaoSocialController.text = cliente!.razaoSocial;
      _nomeFantasiaController.text = cliente!.nomeFantasia;
      _ieController.text = cliente!.ie.toString();

      setState(() {});
    } else if (widget.id.isNotEmpty) {
      Navigator.pop(context);
      errorPopup(
          context: context,
          title: 'Erro ao abrir o cliente',
          text:
              'Não foi possível abrir esse cliente, se persistir entre em contato com o desenvolvedor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(((widget.id.isNotEmpty) ? 'Editar' : 'Novo') + ' Cliente'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomTextField(
                label: 'CNPJ',
                controller: _cnpjController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                  return null;
                }),
            CustomTextField(
                label: 'Razão Social',
                controller: _razaoSocialController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                  return null;
                }),
            CustomTextField(
                label: 'Nome Fantasia', controller: _nomeFantasiaController),
            CustomTextField(
              label: 'Inscrição Estadual',
              controller: _ieController,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Cliente cliente = Cliente(
                          widget.id,
                          int.tryParse(_cnpjController.text) ?? 0,
                          _razaoSocialController.text,
                          _nomeFantasiaController.text,
                          int.tryParse(_ieController.text) ?? 0,
                          ClienteEndereco.empty);

                      (widget.id.isEmpty) ? _save(cliente) : _edit(cliente);
                    }
                  },
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }

  void _save(Cliente cliente) {
    BlocProvider.getBloc<ClientesBloc>().save(cliente).then((e) {
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

  void _edit(Cliente cliente) {
    BlocProvider.getBloc<ClientesBloc>().edit(cliente).then((e) {
      if (e == true) {
        Navigator.pop(context);
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
