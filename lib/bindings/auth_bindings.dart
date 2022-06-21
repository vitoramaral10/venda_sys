import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
