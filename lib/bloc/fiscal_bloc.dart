import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';
import 'package:venda_sys/models/fiscal_xml/nota_fiscal_xml.dart';
import 'package:venda_sys/models/produto.dart';

final Box _box = Hive.box(boxName);
final String _empresa = _box.get('empresa');

class FiscalBloc implements BlocBase {
  final String _collection = 'notas_fiscais';
  final _firestore = FirebaseFirestore.instance.collection('empresas').doc(_empresa);

  final StreamController<List<NotaFiscal>> _fiscalController = StreamController<List<NotaFiscal>>.broadcast();
  Stream get outFiscal => _fiscalController.stream;

  FiscalBloc() {
    search();
  }

  Future<bool> edit(NotaFiscal fiscal) async {
    try {
      await _firestore.collection(_collection).doc(fiscal.id.toString()).set(fiscal.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(NotaFiscal fiscal) async {
    try {
      await _firestore.collection(_collection).doc().set(fiscal.toJson());
      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> search() async {
    _fiscalController.sink.add([]);

    final _notas = await _firestore.collection(_collection).orderBy('identificacao').get();

    _fiscalController.sink.add(_decode(_notas));
  }

  Future<NotaFiscal> getFiscal(String id) async {
    try {
      final _fiscal = await _firestore.collection(_collection).doc(id).get();

      final _fiscalData = _fiscal.data() as Map<String, dynamic>;

      _fiscalData.addAll({'id': id});

      return NotaFiscal.fromJson(_fiscalData);
    } catch (e) {
      return NotaFiscal.empty;
    }
  }

  Future<List<NotaFiscal>> searchBy(String codigo) async {
    try {
      final _docs = await _firestore.collection(_collection).where("codigo", isEqualTo: codigo).get();

      return _decode(_docs);
    } catch (e) {
      return [];
    }
  }

  Future<bool> importXML(BuildContext context, NotaFiscalXML nota) async {
    try {
      //Verifica se a nota já foi importada
      final _doc = await _firestore.collection(_collection).doc(nota.id).get();

      if (!_doc.exists) {
        //Insere a nota
        await _firestore.collection(_collection).doc(nota.id).set(nota.toJson());

        nota.produtos.forEach((produto) async {
          //Verifica se o produto existe
          QuerySnapshot<Map<String, dynamic>> _produtosCadastrados =
              await _firestore.collection('produtos').where('codigo', isEqualTo: produto.codigo).get();

          //Se não existe insere antes de atualizar o histórico
          if (_produtosCadastrados.docs.length == 0) {
            log(produto.unidadeMedida);
            final _unidadeMedida =
                await BlocProvider.getBloc<UnidadesMedidaBloc>().searchBy('sigla', produto.unidadeMedida);
            BlocProvider.getBloc<ProdutosBloc>().save(
              Produto(
                '',
                produto.codigo,
                produto.descricao,
                '',
                0,
                0,
                0,
                produto.ncm,
                _unidadeMedida.id,
              ),
            );

            _produtosCadastrados =
                await _firestore.collection('produtos').where('codigo', isEqualTo: produto.codigo).get();
          }

          //Atualiza o histórico
          _produtosCadastrados.docs.forEach((doc) {
            double _quantidade = double.tryParse(doc.data()['estoque'].toString()) ?? 0;

            final Map<String, dynamic> _update = {};

            if (nota.identificacao.tipo == 0) {
              _update.addAll({'estoque': _quantidade + produto.quantidade});
              _update.addAll({'valorCompra': produto.valorUnitario});
            } else {
              _update.addAll({'estoque': _quantidade - produto.quantidade});
              _update.addAll({'valorVenda': produto.valorUnitario});
            }

            _firestore.collection('produtos').doc(doc.id).update(_update);
          });
        });

        search();

        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Nota já está cadastrada!"),
        ));
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _fiscalController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}

  List<NotaFiscal> _decode(QuerySnapshot response) {
    final fiscal = response.docs.map<NotaFiscal>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return NotaFiscal.fromJson(data);
    }).toList();

    return fiscal;
  }
}
