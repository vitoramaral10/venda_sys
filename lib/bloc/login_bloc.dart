import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/constants.dart';

Box box = Hive.box(boxName);

class LoginBloc implements BlocBase {
  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Map<String, dynamic>? userData = await _checkUserData(email: email);

      box.put('empresa', userData!['empresas'][0]);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> _checkUserData({required String email}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> companies = await firestore
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .get();

    var companies2 = companies.docs;

    return companies2[0].data();
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

  bool checkLogged() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
