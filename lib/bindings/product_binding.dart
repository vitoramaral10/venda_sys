import 'package:get/get.dart';
import 'package:venda_sys/controllers/products_controller.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}
