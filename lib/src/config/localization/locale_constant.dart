import 'dart:ui';

import 'package:get/get.dart';
import 'package:govbot/src/src/dashboard/pages/dashboard_drawe.dart';
import 'package:govbot/src/src/register/view/page/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

class localizationController extends GetxController {
  var token = RxString('');

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
    loadToken(); 
  }

  late SharedPreferences prefs; // SharedPreferences instance
  void loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      updateLanguage(Locale(savedLanguage));
    }
  }

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    prefs.setString('language',
        locale.languageCode); // Save selected language to SharedPreferences
  }

  // Function to save token after login/signup
  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.token.value = token;
    await prefs.setString('jwt_token', token);
    loadToken();
  }
  Future<String?> getToken() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    return token;
  }

  // Function to load and check if the token exists
  void loadToken() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token != null) {
      // If token exists, navigate to the home page
      // You can implement this in your app's main logic or in your authentication flow
      print('Token found: $token');
      // For example, navigate to the home page:
      Get.offAll(() => const DashboardDrawer());
    } else {
      // If token does not exist, navigate to the login or registration page
      print('No token found, navigate to login');
      Get.offAll(
          () => const RegisterPage()); // Navigate to the registration page
    }
  }

  void removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    loadToken();
  }
}
