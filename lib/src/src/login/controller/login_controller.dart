import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/api_paths.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/dashboard/pages/dashboard_drawe.dart';
import 'package:govbot/src/src/login/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../config/localization/locale_constant.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final localizationController controller = Get.find<localizationController>();

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

  Future<void> onLogin() async {
    try {
      final uri = Uri.parse(ApiPaths.login);
      UserModel user = UserModel.withEmailAndPassword(
          email: email.text, password: password.text);
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(user.loginTojason()),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody["message"]);
        controller.saveToken(responseBody["access_token"]);
        Get.snackbar("Success",
            responseBody["message"] ?? "Logged in Successfully",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.green);
        Get.to(const DashboardDrawer());
      } else {
        final errorResponse = jsonDecode(response.body);
        Get.snackbar("Error", errorResponse["detail"] ?? "Failed ",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppTheme.lightAppColors.background,
            backgroundColor: Colors.red);
      }
    } catch(ex) {
      Get.snackbar("ERROR", "$ex ttttttttttt",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }
}
