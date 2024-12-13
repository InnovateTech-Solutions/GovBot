import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/localization/local_strings.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/config/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized before running app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(localizationController()); // Instantiate the controller

  @override
  void initState() {
    super.initState();
    // No need to call loadLanguage() and loadToken here because they're already called in the controller's onInit.
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,
      locale: const Locale('en', 'US'),
      translations: LocalStrings(),
      debugShowCheckedModeBanner: false,
      // Set initial route to null, since we want the controller to handle the navigation
      home: Container(), // Empty container as controller will navigate
    );
  }
}
