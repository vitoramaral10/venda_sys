import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/services/firebase_service.dart';

class AuthController extends GetxController {
  final _userName = ''.obs;

  String get userName => _userName.value;

  set userName(String value) => _userName.value = value;

  void forgot(String text) {}

  Future<void> login(String email, String password) async {
    try {
      User? user = await FirebaseService().signInWithEmailAndPassword(
        email,
        password,
      );

      if (user != null && user.displayName != null) {
        userName = user.displayName!;
      }

      log('user: $user');
      Get.offAllNamed('/home');
    } catch (e) {
      Get.defaultDialog(
        title: 'Erro',
        content: Text(e.toString()),
        actions: [
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () => Get.back(),
          ),
        ],
      );
    }
  }

  void logout() {}
}
