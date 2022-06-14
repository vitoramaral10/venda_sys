import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/clientes_bloc.dart';
import 'package:venda_sys/models/cliente/cliente.dart';
import 'package:venda_sys/models/cliente/endereco.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';
import 'package:venda_sys/models/fiscal_xml/nota_fiscal_xml.dart';

import '../config/constants.dart';

class FiscalBloc implements BlocBase {
  final String _collection = 'notas_fiscais';
  final String _empresa = Constants.box.get('empresa');

  final StreamController<List<NotaFiscal>> _notaFiscalController =
      StreamController<List<NotaFiscal>>.broadcast();
  final StreamController<List<NotaFiscal>> _notaFiscalFilteredController =
      StreamController<List<NotaFiscal>>.broadcast();

  Stream<List<NotaFiscal>> get outNotaFiscal => _notaFiscalController.stream;
  Stream<List<NotaFiscal>> get outNotaFiscalFiltered =>
      _notaFiscalFilteredController.stream;

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
   
  }

  Future<NotaFiscal> getFiscal(String id) async {
    try {
      final fiscal = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .get();

      final fiscalData = fiscal.data() as Map<String, dynamic>;

      fiscalData.addAll({'id': id});

      return NotaFiscal.fromJson(fiscalData);
    } catch (e) {
      return NotaFiscal.empty;
    }
  }

  Future<List<NotaFiscal>> searchBy(String codigo) async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .where("codigo", isEqualTo: codigo)
          .get();

      return _decode(docs);
    } catch (e) {
      return [];
    }
  }

  Future<String> importXML(BuildContext context, NotaFiscalXML nota) async {
    try {
      //Verifica se a nota já foi importada
      final doc = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(nota.id)
          .get();

      if (!doc.exists) {
        //Insere a nota
        await FirebaseFirestore.instance
            .collection('empresas')
            .doc(_empresa)
            .collection(_collection)
            .doc(nota.id)
            .set(nota.toJson());

        nota.products.forEach((product) async {
          //Verifica se o product existe
          QuerySnapshot<Map<String, dynamic>> productsCadastrados =
              await FirebaseFirestore.instance
                  .collection('empresas')
                  .doc(_empresa)
                  .collection('products')
                  .where('codigo', isEqualTo: product.codigo)
                  .get();

          //Se não existe insere antes de atualizar o histórico
          if (productsCadastrados.docs.isEmpty) {
            // final unidadeMedida =
            //     await BlocProvider.getBloc<UnidadesMedidaBloc>()
            //         .searchBy('sigla', product.unidadeMedida);
            // // BlocProvider.getBloc<ProductsBloc>().save(
            //   Product(
            //     '',
            //     product.codigo,
            //     product.descricao,
            //     '',
            //     0,
            //     0,
            //     0,
            //     product.ncm,
            //     unidadeMedida.id,
            //   ),
            // );

            productsCadastrados = await FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection('products')
                .where('codigo', isEqualTo: product.codigo)
                .get();
          }

          //Atualiza o histórico
          for (var doc in productsCadastrados.docs) {
            double quantidade =
                double.tryParse(doc.data()['estoque'].toString()) ?? 0;

            final Map<String, dynamic> update = {};

            if (nota.identificacao.tipo == 0) {
              update.addAll({'estoque': quantidade + product.quantidade});
              update.addAll({'valorCompra': product.valorUnitario});
            } else {
              update.addAll({'estoque': quantidade - product.quantidade});
              update.addAll({'valorVenda': product.valorUnitario});
            }

            FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection('products')
                .doc(doc.id)
                .update(update);
          }
        });

        //Verifica se o cliente existe
        QuerySnapshot<Map<String, dynamic>> clientesCadastrados =
            await FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection('clientes')
                .where('cnpj', isEqualTo: nota.destinatario.cnpj)
                .get();

        //Se não existe insere antes de atualizar o histórico
        if (clientesCadastrados.docs.isEmpty) {
          BlocProvider.getBloc<ClientesBloc>().save(
            Cliente(
              '',
              nota.destinatario.cnpj.toString(),
              nota.destinatario.nome,
              nota.destinatario.nome,
              nota.destinatario.ie.toString(),
              ClienteEndereco(
                nota.destinatario.endereco.logradouro,
                nota.destinatario.endereco.numero,
                nota.destinatario.endereco.bairro,
                nota.destinatario.endereco.municipioCodigo,
                nota.destinatario.endereco.municipio,
                nota.destinatario.endereco.uf,
                nota.destinatario.endereco.cep
                    .replaceAll('-', '')
                    .replaceAll('.', ''),
                nota.destinatario.endereco.paisCodigo,
                nota.destinatario.endereco.pais,
                '',
              ),
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

  Future<void> searchByCnpj(String cnpj) async {
    final notas = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .where('destinatario.cnpj', isEqualTo: cnpj)
        .orderBy('identificacao')
        .get();

    final List<NotaFiscal> fiscais = notas.docs.map((doc) {
      var data = doc.data();

      data['id'] = doc.id;
      return NotaFiscal.fromJson(data);
    }).toList();

    _notaFiscalFilteredController.sink.add(fiscais);
  }
}
