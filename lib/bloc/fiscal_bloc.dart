import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/bloc/clientes_bloc.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/bloc/unidades_medida_bloc.dart';
import 'package:venda_sys/config/config.dart';
import 'package:venda_sys/models/cliente/cliente.dart';
import 'package:venda_sys/models/cliente/endereco.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';
import 'package:venda_sys/models/fiscal_xml/nota_fiscal_xml.dart';
import 'package:venda_sys/models/produto.dart';

final Box _box = Hive.box(boxName);

class FiscalBloc implements BlocBase {
  final String _collection = 'notas_fiscais';
  final String _empresa = _box.get('empresa');

  final StreamController<List<NotaFiscal>> _notaFiscalController =
      StreamController<List<NotaFiscal>>.broadcast();
  Stream<List<NotaFiscal>> get outNotaFiscal => _notaFiscalController.stream;

  Future<bool> edit(NotaFiscal fiscal) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(fiscal.id.toString())
          .set(fiscal.toJson());

      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(NotaFiscal fiscal) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(fiscal.toJson());

      search();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> search() async {
    final _notas = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .orderBy('identificacao')
        .get();

    final List<NotaFiscal> _fiscais = _notas.docs.map((doc) {
      var data = doc.data();

      data['id'] = doc.id;
      return NotaFiscal.fromJson(data);
    }).toList();

    _notaFiscalController.sink.add(_fiscais);
  }

  Future<NotaFiscal> getFiscal(String id) async {
    try {
      final _fiscal = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .get();

      final _fiscalData = _fiscal.data() as Map<String, dynamic>;

      _fiscalData.addAll({'id': id});

      return NotaFiscal.fromJson(_fiscalData);
    } catch (e) {
      return NotaFiscal.empty;
    }
  }

  Future<List<NotaFiscal>> searchBy(String codigo) async {
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

  Future<String> importXML(BuildContext context, NotaFiscalXML nota) async {
    try {
      //Verifica se a nota já foi importada
      final _doc = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(nota.id)
          .get();

      if (!_doc.exists) {
        //Insere a nota
        await FirebaseFirestore.instance
            .collection('empresas')
            .doc(_empresa)
            .collection(_collection)
            .doc(nota.id)
            .set(nota.toJson());

        nota.produtos.forEach((produto) async {
          //Verifica se o produto existe
          QuerySnapshot<Map<String, dynamic>> _produtosCadastrados =
              await FirebaseFirestore.instance
                  .collection('empresas')
                  .doc(_empresa)
                  .collection('produtos')
                  .where('codigo', isEqualTo: produto.codigo)
                  .get();

          //Se não existe insere antes de atualizar o histórico
          if (_produtosCadastrados.docs.isEmpty) {
            final _unidadeMedida =
                await BlocProvider.getBloc<UnidadesMedidaBloc>()
                    .searchBy('sigla', produto.unidadeMedida);
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

            _produtosCadastrados = await FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection('produtos')
                .where('codigo', isEqualTo: produto.codigo)
                .get();
          }

          //Atualiza o histórico
          for (var doc in _produtosCadastrados.docs) {
            double _quantidade =
                double.tryParse(doc.data()['estoque'].toString()) ?? 0;

            final Map<String, dynamic> _update = {};

            if (nota.identificacao.tipo == 0) {
              _update.addAll({'estoque': _quantidade + produto.quantidade});
              _update.addAll({'valorCompra': produto.valorUnitario});
            } else {
              _update.addAll({'estoque': _quantidade - produto.quantidade});
              _update.addAll({'valorVenda': produto.valorUnitario});
            }

            FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection('produtos')
                .doc(doc.id)
                .update(_update);
          }
        });

        //Verifica se o cliente existe
        QuerySnapshot<Map<String, dynamic>> _clientesCadastrados =
            await FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection('clientes')
                .where('cnpj', isEqualTo: nota.destinatario.cnpj)
                .get();

        //Se não existe insere antes de atualizar o histórico
        if (_clientesCadastrados.docs.isEmpty) {
          BlocProvider.getBloc<ClientesBloc>().save(
            Cliente(
              '',
              nota.destinatario.cnpj.toString(),
              nota.destinatario.nome,
              nota.destinatario.nome,
              nota.destinatario.ie.toString(),
              [
                ClienteEndereco(
                  nota.destinatario.endereco.logradouro,
                  nota.destinatario.endereco.numero,
                  nota.destinatario.endereco.bairro,
                  nota.destinatario.endereco.municipioCodigo,
                  nota.destinatario.endereco.municipio,
                  nota.destinatario.endereco.uf,
                  int.parse(nota.destinatario.endereco.cep
                      .replaceAll('-', '')
                      .replaceAll('.', '')),
                  nota.destinatario.endereco.paisCodigo,
                  nota.destinatario.endereco.pais,
                  '',
                ),
              ],
              'J',
              [],
              0,
              '',
              '',
            ),
          );
        }
        search();

        return 'ok';
      } else {
        return 'duplicated';
      }
    } catch (e) {
      return 'error';
    }
  }

  Future cancel(String id) async {
    try {
      final _doc = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .get();
      final _data = _doc.data() as Map<String, dynamic>;
      _data['id'] = _doc.id;

      final _nota = NotaFiscal.fromJson(_data);

      for (var produto in _nota.produtos) {
        final _produtosCadastrados = await FirebaseFirestore.instance
            .collection('empresas')
            .doc(_empresa)
            .collection('produtos')
            .where('codigo', isEqualTo: produto.codigo)
            .get();

        //Atualiza o histórico
        for (var doc in _produtosCadastrados.docs) {
          double _quantidade =
              double.tryParse(doc.data()['estoque'].toString()) ?? 0;

          final Map<String, dynamic> _update = {};

          if (_nota.identificacao.tipo == 1) {
            _update.addAll({'estoque': _quantidade + produto.quantidade});
          } else {
            _update.addAll({'estoque': _quantidade - produto.quantidade});
          }

          FirebaseFirestore.instance
              .collection('empresas')
              .doc(_empresa)
              .collection('produtos')
              .doc(doc.id)
              .update(_update);
        }
      }

      FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .update({'cancelada': true});

      search();
    } catch (e) {
      throw Exception(e);
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

  List<NotaFiscal> _decode(QuerySnapshot response) {
    final fiscal = response.docs.map<NotaFiscal>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return NotaFiscal.fromJson(data);
    }).toList();

    return fiscal;
  }
}
