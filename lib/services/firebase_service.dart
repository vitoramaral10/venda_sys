import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';

import '../config/constants.dart';
import '../models/product.dart';

class FirebaseService {
  FirebaseService();

  Future<void> init() async {
    await Firebase.initializeApp();
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseAuth.instance.setPersistence(Persistence.SESSION);

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

  Future<User?> currentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(milliseconds: 1));

    return currentUser;
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

      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUnitsOfMeasurement() async {
    try {
      final units = await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.unitsOfMeasurement)
          .orderBy('description')
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

  Future<void> createUnitOfMeasurement(UnitOfMeasurement unit) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.unitsOfMeasurement)
          .add(unit.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteUnitOfMeasurement(UnitOfMeasurement unit) async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection('products')
          .where('unitOfMeasurement', isEqualTo: unit.id)
          .get();

      if (docs.docs.isNotEmpty) {
        throw Exception('unit_in_use'.tr);
      } else {
        await FirebaseFirestore.instance
            .collection(Constants.collection)
            .doc(Constants.box.get('empresa'))
            .collection(Constants.unitsOfMeasurement)
            .doc(unit.id)
            .delete();
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.products)
          .get();

      return docs.docs.map((doc) {
        Map<String, dynamic> data = doc.data();

        data['id'] = doc.id;

        return Product.fromJson(data);
      }).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  deleteProduct(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.products)
          .doc(product.id)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }

  createProduct(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.products)
          .add(product.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  updateUnitOfMeasurement(UnitOfMeasurement unit) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.unitsOfMeasurement)
          .doc(unit.id)
          .update(unit.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  updateProduct(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.products)
          .doc(product.id)
          .update(product.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Client>> getClients() async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.clients)
          .get();

      return docs.docs.map((doc) {
        Map<String, dynamic> data = doc.data();

        data['id'] = doc.id;

        return Client.fromJson(data);
      }).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  createClient(Client client) async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection(Constants.collection)
          .doc(Constants.box.get('empresa'))
          .collection(Constants.clients)
          .where({'cnpj': client.cnpj}).get();

      if (docs.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection(Constants.collection)
            .doc(Constants.box.get('empresa'))
            .collection(Constants.clients)
            .add(client.toJson());
      } else {
        throw Exception('Client cadastrado');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  deleteClient(Client client) {
    print(client);
  }

  updateClient(Client client) {
    print(client);
  }
}
