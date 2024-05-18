import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govbot/src/config/localization/lang_list.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/config/sizes/sizes.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/dashboard/controller/dashboard_controller.dart';
import 'package:govbot/src/feature/dashboard/pages/dashboard_page.dart';
import 'package:govbot/src/feature/login/view/pages/login_page.dart';
import 'package:govbot/src/feature/setting/view/setting_page.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final translateController = Get.put(localizationController());

    final controller = Get.put(DashboardController());
    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: context.screenHeight,
            width: context.screenWidth * 0.15,
            color: AppTheme.lightAppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: context.screenWidth * .2,
                    height: context.screenHeight * .1,
                    child: Image.asset("assets/icon2.png")),
                const SizedBox(
                  height: 60,
                ),
                drawerButton("New Chat".tr, Icons.message, () {
                  controller.pageValue.value = 0;
                }),
                const SizedBox(
                  height: 20,
                ),
                drawerButton("Language".tr, Icons.translate, () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Choose a Language".tr),
                        content: SizedBox(
                          width: 150,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Text(Languages.locale[index]['name']),
                                onTap: () {
                                  translateController.updateLanguage(
                                      Languages.locale[index]['locale']);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: Languages.locale.length,
                          ),
                        ),
                      );
                    },
                  );
                }),
                const Spacer(),
                drawerButton("Profile".tr, Icons.person, () {
                  controller.pageValue.value = 2;
                }),
                const SizedBox(
                  height: 60,
                ),
                drawerButton("Logout".tr, Icons.login, () async {
                  await _auth.signOut();
                  Get.to(const LoginPage());
                }),
              ],
            ),
          ),
          Obx(() => Container(
              padding: const EdgeInsets.all(35),
              height: context.screenHeight,
              width: context.screenWidth * 0.85,
              color: const Color.fromARGB(255, 241, 242, 248),
              child: controller.pageValue.value == 0
                  ? const DashboardPage()
                  : SettingPage()))
        ],
      ),
    );
  }

  drawerButton(title, icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.lightAppColors.background,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppTheme.lightAppColors.background,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
