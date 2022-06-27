// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/services/firebase_service.dart';

import '../models/product.dart';

class ProductsController extends GetxController {
  static ProductsController get to => Get.find<ProductsController>();
  final _products = <Product>[].obs;
  final _loading = false.obs;

  List<Product> get products => _products.value;
  bool get loading => _loading.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadProducts();
  }

  Future<void> loadProducts() async {
    _loading.value = true;
    update();

    _products.value = await FirebaseService().getProducts();
    _loading.value = false;

    update();
  }

  Future<void> create(Product product) async {
    try {
      Utils.loading();
      await FirebaseService().createProduct(product);

      await loadProducts();

      Get.back();
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> delete(Product product) async {
    try {
      Utils.loading();
      await FirebaseService().deleteProduct(product);
      await loadProducts();
      Get.back();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      Utils.loading();
      await FirebaseService().updateProduct(product);

      await loadProducts();

      Get.back();
      Get.back();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
