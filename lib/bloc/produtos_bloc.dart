import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:venda_sys/firestore/produtos.dart';
import 'package:venda_sys/models/produto.dart';

class ProdutosBloc implements BlocBase {
  final StreamController<List<Produto>> _produtosController =
      StreamController<List<Produto>>.broadcast();
  Stream get outProdutos => _produtosController.stream;

  ProdutosBloc() {
    search();
  }

  Future<bool> delete(String id) async {
    bool _deleted = await ProdutosFirestore().delete(id);
    if (_deleted == true) {
      search();
    }

    return _deleted;
  }

  edit(Produto produto) async {
    bool _edited = await ProdutosFirestore().edit(produto);
    if (_edited == true) {
      search();
    }

    return _edited;
  }

  Future<bool> save(Produto produto) async {
    bool _saved = await ProdutosFirestore().save(produto);

    if (_saved == true) {
      search();
    }

    return _saved;
  }

  Future<void> search() async {
    // ignore: unnecessary_null_comparison

    _produtosController.sink.add([]);

    List<Produto> _produtos = await ProdutosFirestore().loadProdutos();

    _produtosController.sink.add(_produtos);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _produtosController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}

  Future<Produto> getProduto(String id) async {
    if (id.isNotEmpty) {
      Produto produto = await ProdutosFirestore().getProduto(id);

      return produto;
    } else {
      return Produto.empty;
    }
  }

  Future<List<Produto>> searchBy(String codigo) async {
    return await ProdutosFirestore().searchBy('codigo', isEqualTo: codigo);
  }
}
