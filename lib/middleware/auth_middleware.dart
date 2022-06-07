import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venda_sys/controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    User? userFirebase = FirebaseAuth.instance.currentUser;

    return userFirebase != null ? null : const RouteSettings(name: '/login');
  }
}
