import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/components/custom_text_field.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/produto.dart';
import 'package:venda_sys/models/unidade_medida.dart';

// ignore: must_be_immutable
class ProdutosForm extends StatefulWidget {
  String id;

  ProdutosForm({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  _ProdutosFormState createState() => _ProdutosFormState();
}

class _ProdutosFormState extends State<ProdutosForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorCompraController = TextEditingController();
  final TextEditingController _valorVendaController = TextEditingController();
  final TextEditingController _estoqueController = TextEditingController();
  final TextEditingController _descricaoResumidaController =
      TextEditingController();
  final TextEditingController _ncmController = TextEditingController();

  String unidadeMedida = '';

  Produto? produto;

  @override
  initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    produto = await BlocProvider.getBloc<ProdutosBloc>().getProduto(widget.id);

    if (produto!.id.isNotEmpty) {
      _codigoController.text = produto!.codigo;
      _descricaoController.text = produto!.descricao;
      _descricaoResumidaController.text = produto!.descricaoResumida;
      _valorCompraController.text = (produto!.valorCompra ?? '').toString();
      _valorVendaController.text = (produto!.valorVenda ?? '').toString();
      _estoqueController.text = (produto!.estoque ?? '').toString();
      _ncmController.text = (produto!.ncm ?? '').toString();
      unidadeMedida = produto!.un;

      setState(() {});
    } else if (widget.id.isNotEmpty) {
      Navigator.pop(context);
      errorPopup(
          context: context,
          title: 'Erro ao abrir o produto',
          text:
              'Não foi possível abrir esse produto, se persistir entre em contato com o desenvolvedor');
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<UnidadesMedidaBloc>().search();
    return Scaffold(
      appBar: AppBar(
        title: Text(((widget.id.isNotEmpty) ? 'Editar' : 'Novo') + ' Produto'),
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
                }),
            CustomTextField(
                label: 'Descrição',
                controller: _descricaoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                }),
            CustomTextField(
                label: 'Descrição Resumida',
                controller: _descricaoResumidaController),
            CustomTextField(
                label: 'Valor de Compra', controller: _valorCompraController),
            CustomTextField(
                label: 'Valor de Venda', controller: _valorVendaController),
            CustomTextField(label: 'Estoque', controller: _estoqueController),
            CustomTextField(label: 'NCM', controller: _ncmController),
            StreamBuilder<List<UnidadeMedida>>(
              stream:
                  BlocProvider.getBloc<UnidadesMedidaBloc>().outUnidadesMedida,
              builder: _dropDownUnidadesMedida,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Produto produto = Produto(
                        widget.id,
                        _codigoController.text,
                        _descricaoController.text,
                        _descricaoResumidaController.text,
                        unidadeMedida,
                        valorCompra:
                            double.tryParse(_valorCompraController.text),
                        valorVenda: double.tryParse(_valorVendaController.text),
                        ncm: int.tryParse(_ncmController.text),
                        estoque: int.tryParse(_estoqueController.text),
                      );

                      (widget.id.isEmpty) ? _save(produto) : _edit(produto);
                    }
                  },
                  child: Text('Salvar')),
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
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: unidadeMedidaList
              .map((e) => DropdownMenuItem(
                    child: Text(e.descricao),
                    value: e.id,
                  ))
              .toList(),
          onChanged: (value) {
            unidadeMedida = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo obrigatório';
            }
          },
          value: unidadeMedida,
        ),
      );
    }
    return Container();
  }

  void _save(Produto produto) {
    BlocProvider.getBloc<ProdutosBloc>().save(produto).then((e) {
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

  void _edit(Produto produto) {
    BlocProvider.getBloc<ProdutosBloc>().edit(produto).then((e) {
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

  bool _checkValue(String id, List<UnidadeMedida> unidadeMedidaList) {
    bool _check = false;
    unidadeMedidaList.forEach((element) {
      if (element.id == id) {
        _check = true;
      }
    });

    return _check;
  }
}
