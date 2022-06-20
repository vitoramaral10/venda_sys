import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

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
}
