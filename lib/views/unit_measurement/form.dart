import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/models/unidade_medida.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/error_popup.dart';

class UnitMeasurementFormPage extends GetView {
  final String? id;

  UnitMeasurementFormPage({Key? key, this.id}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _siglaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${(id!.isNotEmpty) ? 'Editar' : 'Nova'} Unidade de Medida',
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
                  return null;
                }),
            CustomTextField(
                label: 'Sigla',
                controller: _siglaController,
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
                      UnidadeMedida unidadeMedida = UnidadeMedida(
                        id!,
                        _descricaoController.text,
                        _siglaController.text,
                      );

                      (id!.isEmpty)
                          ? _save(unidadeMedida)
                          : _edit(unidadeMedida);
                    }
                  },
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }

  void _save(UnidadeMedida unidadeMedida) {
    BlocProvider.getBloc<UnidadesMedidaBloc>().save(unidadeMedida).then((e) {
      if (e == true) {
        Get.back();
      } else {
        errorPopup(
          text: 'Ocorreu um erro ao salvar, tente novamente!',
          title: 'Erro ao salvar',
        );
      }
    });
  }

  void _edit(UnidadeMedida unidadeMedida) {
    BlocProvider.getBloc<UnidadesMedidaBloc>().edit(unidadeMedida).then((e) {
      if (e == true) {
        Get.back();
      } else {
        errorPopup(
          text: 'Ocorreu um erro ao editar, tente novamente!',
          title: 'Erro ao editar',
        );
      }
    });
  }
}
