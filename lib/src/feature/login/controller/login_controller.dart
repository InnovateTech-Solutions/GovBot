import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/feature/dashboard/pages/dashboard_drawe.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? emailValid(String email) {
    if (GetUtils.isEmail(email)) {
      return null;
    } else {
      return "Invalid Email";
    }
  }

  String? vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return "Invalid Password".tr;
    }
    return null;
  }

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<void> onLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        Get.to(const DashboardDrawer());
      } else if (user != null && !user.emailVerified) {
        Get.snackbar(
            "Email not verified", "Please verify your email before logging in.",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.orange);
        await _auth.signOut();
      }
    } on FirebaseAuthException {
      Get.snackbar("ERROR", "The email or password is not valid",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }
}
