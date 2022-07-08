import 'package:get/get.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';

class UnitsOfMeasurementBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnitsOfMeasurementController());
  }
}
