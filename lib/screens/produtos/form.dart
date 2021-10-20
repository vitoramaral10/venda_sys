import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/produto.dart';

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
  final TextEditingController _descricaoResumidaController = TextEditingController();
  final TextEditingController _ncmController = TextEditingController();
  final TextEditingController _unController = TextEditingController();

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
      _valorCompraController.text = produto!.valorCompra.toString();
      _valorVendaController.text = produto!.valorVenda.toString();
      _estoqueController.text = produto!.estoque.toString();
      _ncmController.text = produto!.ncm.toString();
      _unController.text = produto!.un;

      setState(() {});
    } else if (widget.id.isNotEmpty) {
      Navigator.pop(context);
      errorPopup(
          context: context,
          title: 'Erro ao abrir o produto',
          text: 'Não foi possível abrir esse produto, se persistir entre em contato com o desenvolvedor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(((widget.id.isNotEmpty) ? 'Editar' : 'Novo') + ' Produto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            _textField(
                label: 'Código',
                controller: _codigoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                }),
            _textField(
                label: 'Descrição',
                controller: _descricaoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                }),
            _textField(label: 'Descrição Resumida', controller: _descricaoResumidaController),
            _textField(label: 'Valor de Compra', controller: _valorCompraController),
            _textField(label: 'Valor de Venda', controller: _valorVendaController),
            _textField(label: 'Estoque', controller: _estoqueController),
            _textField(label: 'NCM', controller: _ncmController),
            _textField(label: 'Unidade', controller: _unController),
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
                        _unController.text,
                        valorCompra: double.tryParse(_valorCompraController.text),
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

  Padding _textField(
      {required String label, required TextEditingController controller, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        textCapitalization: TextCapitalization.characters,
        validator: validator,
      ),
    );
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
}
