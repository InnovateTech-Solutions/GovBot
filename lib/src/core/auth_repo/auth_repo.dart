// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() async {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  Future<UserCredential> createUserWithEmailPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
  // Future<bool> createUserWithEmailPassword(
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);

  //     return true;
  //   } on FirebaseException catch (e) {
  //     print(e.message);
  //     Get.snackbar("ERROR ", "${e.message}",
  //         snackPosition: SnackPosition.BOTTOM,
  //         colorText: Colors.white,
  //         backgroundColor: Colors.red);
  //     return false;
  //   }
  // }

  Future<void> logout() async => {
        await _auth.signOut(),
      };
}
