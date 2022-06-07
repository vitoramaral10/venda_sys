import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/models/user.dart';

class UsersBloc implements BlocBase {
  final String _collection = 'notas_fiscais';
  final String _empresa = Constants.box.get('empresa');

  Future<bool> edit(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id.toString())
          .set(user.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(User users) async {
    try {
      await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc()
          .set(users.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> search() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('empresas', arrayContains: _empresa)
        .orderBy('nome')
        .get();

    final List<User> listUsers = users.docs.map((doc) {
      Map<String, dynamic> data = doc.data();

      data['id'] = doc.id;

      return User.fromJson(data);
    }).toList();

    return listUsers;
  }

  Future<User?> getUsers(String id) async {
    try {
      final users = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .doc(id)
          .get();

      final usersData = users.data() as Map<String, dynamic>;

      usersData.addAll({'id': id});

      return User.fromJson(usersData);
    } catch (e) {
      return null;
    }
  }

  Future<List<User>> searchBy(String codigo) async {
    try {
      final docs = await FirebaseFirestore.instance
          .collection('empresas')
          .doc(_empresa)
          .collection(_collection)
          .where("codigo", isEqualTo: codigo)
          .get();

      return _decode(docs);
    } catch (e) {
      return [];
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

  List<User> _decode(QuerySnapshot response) {
    final users = response.docs.map<User>((QueryDocumentSnapshot map) {
      final data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return User.fromJson(data);
    }).toList();

    return users;
  }

  Future<void> delete(String id) async {
    try {
      // final data = await FirebaseFirestore.instance.collection('users').doc(id).get();
      // final userData = data.data() as Map<String, dynamic>;

      //User _user = User.fromJson(userData);

      //_user.empresas.remove(_empresa);

      //await FirebaseFirestore.instance.collection('users').doc(id).set(_user.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getUser(String id) async {
    try {
      final user =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      final userData = user.data() as Map<String, dynamic>;

      userData.addAll({'id': id});

      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }
}
