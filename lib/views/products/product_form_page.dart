import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/models/product.dart';
import 'package:venda_sys/models/unidade_medida.dart';

import '../../controllers/products_controller.dart';
import '../widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ProductFormPage extends GetView<ProductsController> {
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

  late Product? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Product'),
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
                      Product product = Product(
                        codigo:_codigoController.text,
                        descricao:_descricaoController.text,
                        descricaoResumida:_descricaoResumidaController.text,
                        estoque: double.tryParse(_estoqueController.text) ?? 0,
                        valorCompra: double.tryParse(_valorCompraController.text) ?? 0,
                        valorVenda: double.tryParse(_valorVendaController.text) ?? 0,
                        ncm: int.tryParse(_ncmController.text) ?? 0,
                        un: unidadeMedida,
                      );

                      controller.save(product);
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
