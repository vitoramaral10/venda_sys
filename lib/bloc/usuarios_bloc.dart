import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/config.dart';
import 'package:venda_sys/models/usuario.dart';

final Box _box = Hive.box(boxName);

class UsuariosBloc implements BlocBase {
  final String _collection = 'notas_fiscais';
  final String _empresa = _box.get('empresa');

  final StreamController<List<Usuario>> _usuariosController = StreamController<List<Usuario>>.broadcast();
  Stream get outUsuarios => _usuariosController.stream;

  UsuariosBloc() {
    search();
  }

  Future<bool> edit(Usuario usuarios) async {
    try {
      await FirebaseFirestore.instance.collection('usuarios').doc(usuarios.id.toString()).set(usuarios.toJson());

      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(Usuario usuarios) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(usuarios.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> search() async {
    _usuariosController.sink.add([]);

    final _usuarios = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('empresas', arrayContains: _empresa)
        .orderBy('nome')
        .get();

    _usuariosController.sink.add(_decode(_usuarios));
  }

  Future<Usuario> getUsuarios(String id) async {
    try {
      final _usuarios =
          await FirebaseFirestore.instance.collection('empresas').doc(_empresa).collection(_collection).doc(id).get();

      final _usuariosData = _usuarios.data() as Map<String, dynamic>;

      _usuariosData.addAll({'id': id});

      return Usuario.fromJson(_usuariosData);
    } catch (e) {
      return Usuario.empty;
    }
  }

  Future<List<Usuario>> searchBy(String codigo) async {
    try {
      final _docs = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .where("codigo", isEqualTo: codigo)
          .get();

      return _decode(_docs);
    } catch (e) {
      return [];
    }
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _usuariosController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}

  List<Usuario> _decode(QuerySnapshot response) {
    final usuarios = response.docs.map<Usuario>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return Usuario.fromJson(data);
    }).toList();

    return usuarios;
  }

  Future<void> delete(String id) async {
    try {
      final data = await FirebaseFirestore.instance.collection('usuarios').doc(id).get();
      final usuarioData = data.data() as Map<String, dynamic>;

      Usuario _usuario = Usuario.fromJson(usuarioData);

      //_usuario.empresas.remove(_empresa);

      //await FirebaseFirestore.instance.collection('usuarios').doc(id).set(_usuario.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Usuario> getUsuario(String id) async {
    try {
      final usuario = await FirebaseFirestore.instance.collection('usuarios').doc(id).get();
      final usuarioData = usuario.data() as Map<String, dynamic>;

      usuarioData.addAll({'id': id});

      return Usuario.fromJson(usuarioData);
    } catch (e) {
      return Usuario.empty;
    }
  }
}
