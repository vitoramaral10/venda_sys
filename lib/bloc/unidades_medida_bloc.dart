import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/firestore/unidades_medida.dart';
import 'package:venda_sys/models/unidade_medida.dart';

class UnidadesMedidaBloc implements BlocBase {
  final StreamController<List<UnidadeMedida>> _unidadesMedidasController =
      StreamController<List<UnidadeMedida>>.broadcast();
  Stream<List<UnidadeMedida>> get outUnidadesMedida => _unidadesMedidasController.stream;

  // ignore: non_constant_identifier_names
  UnidadesMedidasBloc() {
    search();
  }

  Future<bool> delete(String id, BuildContext context) async {
    bool _deleted = await UnidadesMedidaFirestore().delete(id, context);
    if (_deleted == true) {
      search();
    }

    return _deleted;
  }

  Future<bool> edit(UnidadeMedida unidadesMedida) async {
    bool _edited = await UnidadesMedidaFirestore().edit(unidadesMedida);
    if (_edited == true) {
      search();
    }

    return _edited;
  }

  Future<bool> save(UnidadeMedida unidadesMedida) async {
    bool _saved = await UnidadesMedidaFirestore().save(unidadesMedida);

    if (_saved == true) {
      search();
    }

    return _saved;
  }

  Future<void> search() async {
    // ignore: unnecessary_null_comparison

    _unidadesMedidasController.sink.add([]);

    List<UnidadeMedida> _unidadesMedidas = await UnidadesMedidaFirestore().loadUnidadesMedida();
    
    _unidadesMedidasController.sink.add(_unidadesMedidas);
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

  Future<UnidadeMedida> getUnidadeMedida(String id) async {
    if (id.isNotEmpty) {
      UnidadeMedida unidadesMedida = await UnidadesMedidaFirestore().getUnidadeMedida(id);

      return unidadesMedida;
    } else {
      return UnidadeMedida.empty;
    }
  }
}
