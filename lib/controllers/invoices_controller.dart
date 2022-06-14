import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';

import '../config/constants.dart';

class InvoicesController extends GetxController {
  final String _collection = 'notas_fiscais';
  final String _empresa = Constants.box.get('empresa');
  final _invoices = [].obs;
  final _loading = false.obs;

  // ignore: invalid_use_of_protected_member
  List get invoices => _invoices.value;
  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    _loading.value = true;
    update();

    final notas = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .orderBy('identificacao')
        .get();

    final List<NotaFiscal> invoices = notas.docs.map((doc) {
      var data = doc.data();

      data['id'] = doc.id;

      return NotaFiscal.fromJson(data);
    }).toList();

    _invoices.value = invoices;
    _loading.value = false;
    update();
  }

  Future<void> cancel(NotaFiscal invoice) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(invoice.id)
          .get();
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;

      final nota = NotaFiscal.fromJson(data);

      for (var product in nota.products) {
        final productsCadastrados = await FirebaseFirestore.instance
            .collection('empresas')
            .doc(_empresa)
            .collection('products')
            .where('codigo', isEqualTo: product.codigo)
            .get();

        //Atualiza o histórico
        for (var doc in productsCadastrados.docs) {
          double quantidade =
              double.tryParse(doc.data()['estoque'].toString()) ?? 0;

          final Map<String, dynamic> update = {};

          if (nota.identificacao.tipo == 1) {
            update.addAll({'estoque': quantidade + product.quantidade});
          } else {
            update.addAll({'estoque': quantidade - product.quantidade});
          }

          FirebaseFirestore.instance
              .collection('empresas')
              .doc(_empresa)
              .collection('products')
              .doc(doc.id)
              .update(update);
        }
      }

      FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(nota.id)
          .update({'cancelada': true});

      load();
    } catch (e) {
      log(e.toString(), name: 'InvoicesController.cancel');
    }
  }
}
