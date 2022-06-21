import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';

import '../config/constants.dart';

class FirebaseService {
  FirebaseService();

  Future<void> init() async {
    await Firebase.initializeApp();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('user_not_found'.tr);
      } else if (e.code == 'wrong-password') {
        throw Exception('wrong_password'.tr);
      } else {
        throw Exception('error'.tr);
      }
    }
  }

  void currentUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      Get.offAllNamed('/login');
    }
  }

  Future<List<Map<String, dynamic>>> getUnitsOfMeasurement() async {
    try {
      final units = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(Constants.box.get('empresa'))
          .collection(Constants.unitsOfMeasurement)
          .get();

      return units.docs.map((doc) {
        Map<String, dynamic> data = doc.data();

        data['id'] = doc.id;

        return data;
      }).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String? email) async {
    try {
      final companies = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: email)
          .get();

      return companies.docs[0].data();
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> createUnitOfMeasurement(UnitOfMeasurement unit) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(Constants.box.get('empresa'))
          .collection(Constants.unitsOfMeasurement)
          .add(unit.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
