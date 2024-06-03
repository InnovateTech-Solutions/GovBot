import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/core/auth_repo/auth_repo.dart';
import 'package:govbot/src/feature/dashboard/pages/dashboard_drawe.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final _db = FirebaseFirestore.instance;

  final confirmPassword = TextEditingController();

  validEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return "Email is Invalid";
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!) && phoneNumber.length >= 9) {
      return null;
    }
    return "Phone number is Invalid";
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is Invalid';
    }
    return null;
  }

  validName(String? name) {
    if (name!.isEmpty) {
      return "Name is Invalid";
    }
    return null;
  }

  vaildateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<bool> isUsernameTaken(String username) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Users')
          .where('UserName', isEqualTo: username)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      Get.snackbar("Error", "Error checking username: $error",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
      return false;
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").add(user.tojason());
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendEmailVerification(User user) async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      Get.snackbar("Error", "Could not send email verification: $e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
    }
  }

  Future<void> onSignup(UserModel user) async {
    try {
      bool usernameCheck = await isUsernameTaken(user.name);
      if (!usernameCheck) {
        AuthenticationRepository authRepo = AuthenticationRepository();
        UserCredential userCredential = await authRepo
            .createUserWithEmailPassword(user.email, user.password);
        if (userCredential.user != null) {
          await createUser(user);
          await sendEmailVerification(userCredential.user!);
          Get.snackbar(
              "Success", "Account Created Successfully. Verify your email.",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.green);
          // Prompt the user to verify their email and not navigate to the dashboard
          Get.defaultDialog(
            title: "Verify Email",
            middleText:
                "A verification email has been sent to ${user.email}. Please verify your email before logging in.",
            onConfirm: () => Get.back(), // Close dialog
            textConfirm: "OK",
          );
        } else {
          Get.snackbar("ERROR", "Invalid Data",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("ERROR", "Username is taken",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
    }
  }

  Future<void> checkEmailVerification(User user) async {
    user.reload();
    if (user.emailVerified) {
      Get.snackbar("Success", "Email verified successfully.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.green);
      Get.to(const DashboardDrawer());
    } else {
      Get.snackbar("Error", "Email is not verified. Please verify your email.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
    }
  }

  Future<void> onLogin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await checkEmailVerification(userCredential.user!);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Login failed: $e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
    }
  }
}
