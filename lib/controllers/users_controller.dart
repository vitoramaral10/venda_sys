import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';

import '../models/user.dart';

class UsersController extends GetxController {
  final String _collection = 'notas_fiscais';
  final String _empresa = Constants.box.get('empresa');

  Future<User> getUsers(String id) async {
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
      return User.empty;
    }
  }
}
