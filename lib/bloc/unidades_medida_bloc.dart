import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/config.dart';
import 'package:venda_sys/models/unidade_medida.dart';

Box _box = Hive.box(boxName);

class UnidadesMedidaBloc implements BlocBase {
  final String _collection = 'unidades_medidas';
  final String _empresa = _box.get('empresa');

  final StreamController<List<UnidadeMedida>> _unidadesMedidasController =
      StreamController<List<UnidadeMedida>>.broadcast();
  Stream<List<UnidadeMedida>> get outUnidadesMedida => _unidadesMedidasController.stream;

  // ignore: non_constant_identifier_names
  UnidadesMedidasBloc() {
    search();
  }

  Future<bool> delete(String id, BuildContext context) async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection('produtos')
          .where('un', isEqualTo: id)
          .get();

      if (docs.docs.length == 0) {
        await FirebaseFirestore.instance.collection('empresas').doc(_empresa).collection(_collection).doc(id).delete();
        search();

        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unidade de Medida está sendo utilizada!"),
        ));
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(UnidadeMedida unidadesMedida) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(unidadesMedida.id)
          .set(unidadesMedida.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(UnidadeMedida unidadesMedida) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(unidadesMedida.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> search() async {
    _unidadesMedidasController.sink.add([]);

    final unidadesMedida =
        await FirebaseFirestore.instance.collection('empresas').doc(_empresa).collection(_collection).get();
    log(_empresa);
    log(unidadesMedida.docs.toString());
    _unidadesMedidasController.sink.add(_decode(unidadesMedida));
  }

  Future<UnidadeMedida> getUnidadeMedida(String id) async {
    try {
      final unidadesMedida =
          await FirebaseFirestore.instance.collection('empresas').doc(_empresa).collection(_collection).doc(id).get();

      final unidadesMedidaData = unidadesMedida.data() as Map<String, dynamic>;

      unidadesMedidaData.addAll({'id': id});

      return UnidadeMedida.fromJson(unidadesMedidaData);
    } catch (e) {
      return UnidadeMedida.empty;
    }
  }

  Future<UnidadeMedida> searchBy(String field, String descricao) async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .where(field, isEqualTo: descricao)
          .get();

      final data = docs.docs[0].data();
      data['id'] = docs.docs[0].id;

      return UnidadeMedida.fromJson(data);
    } catch (e) {
      return UnidadeMedida.empty;
    }
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _unidadesMedidasController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}

  List<UnidadeMedida> _decode(QuerySnapshot response) {
    final unidadesMedidas = response.docs.map<UnidadeMedida>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return UnidadeMedida.fromJson(data);
    }).toList();

    return unidadesMedidas;
  }
}
