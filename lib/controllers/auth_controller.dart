import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/services/firebase_service.dart';

import '../config/constants.dart';

class AuthController extends GetxController {
  final _userName = ''.obs;

  String get userName => _userName.value;

  set userName(String value) => _userName.value = value;

  void forgot(String text) {
    print(text);
  }

  Future<void> login(String email, String password) async {
    try {
      Utils.loading();
      User? user = await FirebaseService().signInWithEmailAndPassword(
        email,
        password,
      );

      if (user != null && user.displayName != null) {
        userName = user.displayName!;
      }

      Map<String, dynamic>? userData =
          await FirebaseService().getUserData(user!.email);

      Constants.box.put('empresa', userData!['empresas'][0]);

      Get.offAndToNamed('/home');
    } catch (e) {
      Get.back();

      Utils.dialog(
        content: const Text(
          "Parece que ocorreu um erro ao tentar realizar o login.\nPor favor, verifique suas credenciais e tente novamente.",
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await Constants.box.clear();
      Get.offAllNamed('/login');
    } catch (e) {
      log(e.toString(), name: 'logout');
    }
  }
}
