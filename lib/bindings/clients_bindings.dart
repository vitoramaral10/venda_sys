import 'package:get/get.dart';
import 'package:venda_sys/controllers/clients_controller.dart';

class ClientsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientsController());
  }
}
