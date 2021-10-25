import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/components/custom_text_field.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/unidade_medida.dart';

// ignore: must_be_immutable
class UnidadesMedidaForm extends StatefulWidget {
  String id;

  UnidadesMedidaForm({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  _UnidadesMedidaFormState createState() => _UnidadesMedidaFormState();
}

class _UnidadesMedidaFormState extends State<UnidadesMedidaForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _siglaController = TextEditingController();

  UnidadeMedida? unidadeMedida;

  @override
  initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    unidadeMedida = await BlocProvider.getBloc<UnidadesMedidaBloc>().getUnidadeMedida(widget.id);

    if (unidadeMedida!.id.isNotEmpty) {
      _descricaoController.text = unidadeMedida!.descricao;
      _siglaController.text = unidadeMedida!.sigla;

      setState(() {});
    } else if (widget.id.isNotEmpty) {
      Navigator.pop(context);
      errorPopup(
          context: context,
          title: 'Erro ao abrir a unidade de medida',
          text: 'Não foi possível abrir essa unidade de medida, se persistir entre em contato com o desenvolvedor');
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
                label: 'Descrição',
                controller: _descricaoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                }),
            CustomTextField(
                label: 'Sigla',
                controller: _siglaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UnidadeMedida unidadeMedida = UnidadeMedida(
                        widget.id,
                        _descricaoController.text,
                        _siglaController.text,
                      );

                      (widget.id.isEmpty) ? _save(unidadeMedida) : _edit(unidadeMedida);
                    }
                  },
                  child: Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }

  void _save(UnidadeMedida unidadeMedida) {
    BlocProvider.getBloc<UnidadesMedidaBloc>().save(unidadeMedida).then((e) {
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

  void _edit(UnidadeMedida unidadeMedida) {
    BlocProvider.getBloc<UnidadesMedidaBloc>().edit(unidadeMedida).then((e) {
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
