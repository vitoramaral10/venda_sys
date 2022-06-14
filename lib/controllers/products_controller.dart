import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../models/product.dart';

class ProductsController extends GetxController {
  final String _collection = 'produtos';
  final String _empresa = Constants.box.get('empresa');
  final _products = [].obs;
  final _loading = false.obs;

  // ignore: invalid_use_of_protected_member
  List get products => _products.value;
  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    _loading.value = true;
    update();

    final data = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .orderBy('descricao')
        .get();

    final List<Product> products = data.docs.map((e) {
      Product product = Product.fromJson(e.data());

      product.id = e.id;

      return product;
    }).toList();

    _products.value = products;
    _loading.value = false;
    update();
  }

  void delete(Product product) {
    Get.defaultDialog(
      title: 'Excluir Produto',
      content: Text('Deseja excluir o produto ${product.descricao}?'),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          child: const Text('Excluir'),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('empresas')
                .doc(_empresa)
                .collection(_collection)
                .doc(product.id)
                .delete();

            load();
            Get.back();
          },
        ),
      ],
    );
  }

  void save(Product product) {
    if (product.id == null) {
      FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(product.toJson());
    } else {
      FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(product.id)
          .set(product.toJson());
    }

    load();

    Get.back();
  }
}
