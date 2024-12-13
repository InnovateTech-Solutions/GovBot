import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/api_paths.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/login/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingController extends GetxController {
  final email = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final confirmPassword = TextEditingController();
  final localizationController tokenController =
      Get.find<localizationController>();


  // Validators
  String? validEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return "Email is not valid";
  }

  String? vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!) && phoneNumber.length >= 9) {
      return null;
    }
    return "Invalid Phone number";
  }

  String? validName(String? address) {
    if (address!.isEmpty) {
      return "Username is not valid";
    }
    return null;
  }

  // Fetch user details via API
  Future<UserModel> getUserDetails() async {
    final url = Uri.parse(ApiPaths.getUserInfo);
    var token = await tokenController
        .getToken(); // Replace with your method to fetch the token
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Include the token in the header
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      final userData = UserModel.fromJson(data);
      print("//////////////////////////////////////:    ${userData}");

      this.email.text = userData.email;
      name.text = userData.name;
      return userData;
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Update user details via API
  Future<void> updateUserData(String? userId) async {
    final url = Uri.parse(ApiPaths.updateUserInfo);
    var token = await tokenController
        .getToken(); // Replace with your method to fetch the token

    final body = jsonEncode({
      'name': name.text,
    });

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token in the header
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Account Updated Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to update account: ${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to connect: $e",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
