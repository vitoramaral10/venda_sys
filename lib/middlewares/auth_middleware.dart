import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/services/firebase_service.dart';

import '../controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (Constants.box.get('empresa', defaultValue: '') == '') {
      authController.logout();
    }

    return null;
  }
}
