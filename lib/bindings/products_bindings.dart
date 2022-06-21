import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}
