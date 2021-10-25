import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/config.dart';
import 'package:venda_sys/models/produto.dart';

Box _box = Hive.box(boxName);

class ProdutosBloc implements BlocBase {
  final String _collection = 'produtos';
  final String _empresa = _box.get('empresa');

  final StreamController<List<Produto>> _produtosController = StreamController<List<Produto>>.broadcast();
  Stream get outProdutos => _produtosController.stream;

  ProdutosBloc() {
    search();
  }

  Future<bool> delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('empresas').doc(_empresa).collection(_collection).doc(id).delete();
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(Produto produto) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(produto.id)
          .set(produto.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(Produto produto) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(produto.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> search() async {
    _produtosController.sink.add([]);
    final _data = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .orderBy('descricao')
        .get();
    log(_data.docs.toString());
    _produtosController.sink.add(_decode(_data));
  }

  Future<Produto> getProduto(String id) async {
    try {
      final produto =
          await FirebaseFirestore.instance.collection('empresas').doc(_empresa).collection(_collection).doc(id).get();
      final produtoData = produto.data() as Map<String, dynamic>;

      produtoData.addAll({'id': id});

      return Produto.fromJson(produtoData);
    } catch (e) {
      return Produto.empty;
    }
  }

  Future<List<Produto>> searchBy(String codigo) async {
    try {
      final _docs = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .where('codigo', isEqualTo: codigo)
          .get();

      return _decode(_docs);
    } catch (e) {
      return const [];
    }
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

  List<Produto> _decode(QuerySnapshot response) {
    final produtos = response.docs.map<Produto>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;

      data['id'] = map.id;
      return Produto.fromJson(data);
    }).toList();

    return produtos;
  }
}
