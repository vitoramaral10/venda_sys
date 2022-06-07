import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/users_controller.dart';
import 'package:venda_sys/models/user.dart' as u;

class AuthController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final String _collection = 'usuarios';

  final _user = u.User.empty.obs;

  u.User get user => _user.value;

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final userData = await _checkUserData(email: email);
      Constants.box.put('empresa', userData!['empresas'][0]);

      Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: 'Erro',
          middleText: 'Usuário não encontrado',
          confirm: ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Ok'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: 'Erro',
          middleText: 'Senha incorreta',
          confirm: ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Ok'),
          ),
        );
      } else {
        Get.defaultDialog(
          title: 'Erro',
          middleText: 'Erro ao fazer login',
          confirm: ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Ok'),
          ),
        );
      }

      log(e.toString());
    }
  }

  Future<void> checkLogged() async {
    final userFirebase = _firebaseAuth.currentUser;

    if (userFirebase != null) {
      _user.value = await UsersController().getUsers(userFirebase.uid);
      update();
    } else {
      Get.toNamed('/logout');
    }
  }

  Future<Map<String, dynamic>?> _checkUserData({required String email}) async {
    try {
      final companies = await _firestore
          .collection(_collection)
          .where('email', isEqualTo: email)
          .get();
      return companies.docs[0].data();
    } catch (e) {
      throw Exception(e);
    }
  }

  void logout() {}
}
