import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/constants.dart';

Box box = Hive.box(boxName);

class LoginBloc implements BlocBase {
  final String _collection = 'notas_fiscais';
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final userData = await _checkUserData(email: email);

      box.put('empresa', userData!['empresas'][0]);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> _checkUserData({required String email}) async {
    final companies = await _firestore.collection(_collection).where('email', isEqualTo: email).get();

    return companies.docs[0].data();
  }

  bool checkLogged() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
