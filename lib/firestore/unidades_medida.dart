import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/models/unidade_medida.dart';

class UnidadesMedidaFirestore {
  final String _collection = 'unidades_medidas';

  Future<List<UnidadeMedida>> loadUnidadesMedida() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> unidadesMedida = await firestore.collection(_collection).get();

    return _decode(unidadesMedida);
  }

  List<UnidadeMedida> _decode(QuerySnapshot response) {
    List<UnidadeMedida> unidadesMedidas = response.docs.map<UnidadeMedida>((QueryDocumentSnapshot map) {
      Map<String, dynamic> data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return UnidadeMedida.fromJson(data);
    }).toList();

    return unidadesMedidas;
  }

  Future<bool> save(UnidadeMedida unidadesMedida) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection(_collection).doc().set(unidadesMedida.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String id, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot<Map<String, dynamic>> docs =
          await firestore.collection('produtos').where('un', isEqualTo: id).get();

      if (docs.docs.length == 0) {
        await firestore.collection(_collection).doc(id).delete();
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

  Future<UnidadeMedida> getUnidadeMedida(String id) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot<Map<String, dynamic>> unidadesMedida = await firestore.collection(_collection).doc(id).get();

      Map<String, dynamic> unidadesMedidaData = unidadesMedida.data() as Map<String, dynamic>;

      unidadesMedidaData.addAll({'id': id});

      return UnidadeMedida.fromJson(unidadesMedidaData);
    } catch (e) {
      return UnidadeMedida.empty;
    }
  }

  Future<bool> edit(UnidadeMedida unidadesMedida) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection(_collection).doc(unidadesMedida.id).set(unidadesMedida.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }
}
