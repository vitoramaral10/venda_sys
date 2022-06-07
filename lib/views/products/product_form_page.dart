import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/models/product.dart';
import 'package:venda_sys/models/unidade_medida.dart';

import '../widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ProductFormPage extends GetView {
  ProductFormPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorCompraController = TextEditingController();
  final TextEditingController _valorVendaController = TextEditingController();
  final TextEditingController _estoqueController = TextEditingController();
  final TextEditingController _descricaoResumidaController =
      TextEditingController();
  final TextEditingController _ncmController = TextEditingController();

  late String unidadeMedida = '';

  late Product? produto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomTextField(
                label: 'Código',
                controller: _codigoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                  return null;
                }),
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
                label: 'Descrição Resumida',
                controller: _descricaoResumidaController),
            CustomTextField(
              label: 'Valor de Compra',
              controller: _valorCompraController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'Valor de Venda',
              controller: _valorVendaController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'Estoque',
              controller: _estoqueController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'NCM',
              controller: _ncmController,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Product produto = Product(
                        '',
                        _codigoController.text,
                        _descricaoController.text,
                        _descricaoResumidaController.text,
                        double.tryParse(_estoqueController.text) ?? 0,
                        double.tryParse(_valorCompraController.text) ?? 0,
                        double.tryParse(_valorVendaController.text) ?? 0,
                        int.tryParse(_ncmController.text) ?? 0,
                        unidadeMedida,
                      );

                      _save(produto);
                    }
                  },
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }

  Widget _dropDownUnidadesMedida(context, snapshot) {
    if (snapshot.hasData && snapshot.data!.length > 0) {
      List<UnidadeMedida> unidadeMedidaList = snapshot.data!;

      unidadeMedidaList.add(UnidadeMedida('', 'Selecione', ''));

      unidadeMedida =
          _checkValue(unidadeMedida, unidadeMedidaList) ? unidadeMedida : '';

      unidadeMedidaList.sort((a, b) => a.sigla.compareTo(b.sigla));

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          isDense: true,
          items: unidadeMedidaList
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.descricao),
                  ))
              .toList(),
          onChanged: (value) {
            unidadeMedida = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
          value: unidadeMedida,
        ),
      );
    }
    return Container();
  }

  void _save(Product produto) {
    // BlocProvider.getBloc<ProdutosBloc>().save(produto).then((e) {
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

  void _edit(Product produto) {
    // BlocProvider.getBloc<ProdutosBloc>().edit(produto).then((e) {
    //   if (e == true) {
    //     Navigator.pop(context);
    //   } else {
    //     errorPopup(
    //       text: 'Ocorreu um erro ao editar, tente novamente!',
    //       title: 'Erro ao editar',
    //     );
    //   }
    // });
  }

  bool _checkValue(String id, List<UnidadeMedida> unidadeMedidaList) {
    bool check = false;
    for (var element in unidadeMedidaList) {
      if (element.id == id) {
        check = true;
      }
    }

    return check;
  }
}
