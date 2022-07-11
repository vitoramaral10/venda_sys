import 'package:get/get.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';

import '../controllers/products_controller.dart';

class ProductsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => UnitsOfMeasurementController());
  }
}
