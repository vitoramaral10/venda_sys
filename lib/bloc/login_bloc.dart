import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../config/constants.dart';

class LoginBloc implements BlocBase {
  final _firebaseAuth = FirebaseAuth.instance;

  bool isLoggedIn() {
    final user = _firebaseAuth.currentUser;

    return user != null;
  }

 

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      Constants.box.clear();
    } catch (e) {
      throw Exception(e);
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
