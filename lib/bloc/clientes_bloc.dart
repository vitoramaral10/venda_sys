import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/config.dart';

import '../models/cliente/cliente.dart';

Box _box = Hive.box(boxName);

class ClientesBloc implements BlocBase {
  final String _collection = 'clientes';
  String _empresa = _box.get('empresa');

  final StreamController<List<Cliente>> _clientesController =
      StreamController<List<Cliente>>.broadcast();
  Stream get outClientes => _clientesController.stream;

  Future<bool> delete(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .delete();

      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(Cliente cliente) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(cliente.id)
          .set(cliente.toJson());

      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(Cliente cliente) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(cliente.toJson());

      search();

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> search() async {
    _empresa = _box.get('empresa');

    final _data = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .orderBy('razaoSocial')
        .get();

    _clientesController.sink.add(_decode(_data));
  }

  Future<Cliente> getCliente(String id) async {
    try {
      final cliente = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .get();
      final clienteData = cliente.data() as Map<String, dynamic>;

      clienteData.addAll({'id': id});

      return Cliente.fromJson(clienteData);
    } catch (e) {
      return Cliente.empty;
    }
  }

  Future<List<Cliente>> searchBy(String codigo) async {
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
  void dispose() {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}

  List<Cliente> _decode(QuerySnapshot response) {
    final clientes = response.docs.map<Cliente>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;

      data['id'] = map.id;
      return Cliente.fromJson(data);
    }).toList();

    return clientes;
  }
}
