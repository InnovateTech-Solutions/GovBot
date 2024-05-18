import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/firebase_options.dart';
import 'package:govbot/src/config/localization/local_strings.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/core/auth_repo/auth_repo.dart';
import 'package:govbot/src/feature/login/view/pages/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(localizationController());

  @override
  void initState() {
    super.initState();
    controller.loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,
      locale: const Locale('en', 'US'),
      translations: LocalStrings(),
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}
