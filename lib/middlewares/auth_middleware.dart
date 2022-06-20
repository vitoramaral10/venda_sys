import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venda_sys/services/firebase_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    FirebaseService().currentUser();
  }
}
