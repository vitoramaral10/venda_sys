import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../models/product.dart';

class ProductsController extends GetxController {
  final String _collection = 'produtos';
  final String _empresa = Constants.box.get('empresa');
  final _products = [].obs;

  // ignore: invalid_use_of_protected_member
  List get products => _products.value;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    final data = await FirebaseFirestore.instance
        .collection('empresas')
        .doc(_empresa)
        .collection(_collection)
        .orderBy('descricao')
        .get();

    final List<Product> produtos = data.docs.map((e) {
      Product produto = Product.fromJson(e.data());

      produto.id = e.id;

      return produto;
    }).toList();

    _products.value = produtos;
    update();
  }
}
