import 'package:cloud_firestore/cloud_firestore.dart';
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
    return "Email is  Inalid";
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!) && phoneNumber.length >= 9) {
      return null;
    }
    return " Phone number is Invalid";
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is  Invaild';
    }
    return null;
  }

  validName(String? address) {
    if (address!.isEmpty) {
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
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
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

  Future<void> onSignup(UserModel user) async {
    try {
      bool usernameCheck = await isUsernameTaken(user.name);
      if (!usernameCheck) {
        Future<bool> code = AuthenticationRepository()
            .createUserWithEmailPassword(user.email, user.password);
        if (await code) {
          createUser(user);
          Get.snackbar("Success", " Account  Created Successfullly",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.green);
          Get.to(const DashboardDrawer());
          ;
        } else {
          Get.snackbar("ERROR", "Invalid Data",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("ERROR", "Username  is taken",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }
}
