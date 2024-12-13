import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/api_paths.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/dashboard/pages/dashboard_drawe.dart';
import 'package:govbot/src/src/login/model/user_model.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final localizationController controller = Get.find<localizationController>();

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

  Future<void> createUser(UserModel user) async {
    try {
      final uri = Uri.parse(ApiPaths.signup);
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(user.tojason()),
      );
      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        print(responseBody["message"]);
        controller.saveToken(responseBody["access_token"]);
        Get.snackbar("Success",
            responseBody["message"] ?? "Account Created Successfully",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.green);
        Get.to(const DashboardDrawer());
      } else {
        final errorResponse = jsonDecode(response.body);
        Get.snackbar("Error", errorResponse["detail"] ?? "",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
      print(e);
    }
  }

}
