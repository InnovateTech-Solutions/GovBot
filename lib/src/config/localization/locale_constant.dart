import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

class localizationController extends GetxController {
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
}
