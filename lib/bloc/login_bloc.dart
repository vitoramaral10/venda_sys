import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/bloc/usuarios_bloc.dart';
import 'package:venda_sys/config/config.dart';
import 'package:venda_sys/models/usuario.dart';

Box box = Hive.box(boxName);

class LoginBloc implements BlocBase {
  final String _collection = 'usuarios';
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final userData = await _checkUserData(email: email);
      box.put('empresa', userData!['empresas'][0]);
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed with error code: ${e.code}');
    }
  }

  bool isLoggedIn() {
    final user = _firebaseAuth.currentUser;

    return user != null;
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

  Future<Usuario> checkLogged() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final usuario =
          await BlocProvider.getBloc<UsuariosBloc>().getUsuario(user.uid);

      return usuario;
    } else {
      return Usuario.empty;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      box.clear();
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
