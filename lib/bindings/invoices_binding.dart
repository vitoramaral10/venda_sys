import 'package:get/get.dart';
import 'package:venda_sys/controllers/invoices_controller.dart';

class InvoicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoicesController());
  }
}
