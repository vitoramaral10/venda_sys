// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:venda_sys/services/firebase_service.dart';

import '../models/product.dart';

class ProductsController extends GetxController {
  final _products = <Product>[].obs;
  final _loading = false.obs;

  static ProductsController get to => Get.find<ProductsController>();
  List<Product> get products => _products.value;
  bool get loading => _loading.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      _loading.value = true;
      update();

      _products.value = await FirebaseService().getProducts();
      _loading.value = false;

      update();
    } catch (e) {
      log(e.toString(), name: 'loadProducts');
    }
  }

  Future<void> create(Product product) async {
    try {
      await FirebaseService().createProduct(product);

      await loadProducts();
    } catch (e) {
      log(e.toString(), name: 'createProduct');

      rethrow;
    }
  }

  Future<void> delete(Product product) async {
    try {
      await FirebaseService().deleteProduct(product);
      await loadProducts();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await FirebaseService().updateProduct(product);

      await loadProducts();
    } catch (e) {
      log(e.toString(), name: 'updateProduct');
      rethrow;
    }
  }
}
