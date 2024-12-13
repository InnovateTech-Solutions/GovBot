import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govbot/src/config/localization/lang_list.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/dashboard/controller/dashboard_controller.dart';
import 'package:govbot/src/src/dashboard/pages/dashboard_page.dart';
import 'package:govbot/src/src/history/view/history_page.dart';
import 'package:govbot/src/src/reports/view/reports_page.dart';
import 'package:govbot/src/src/setting/view/setting_page.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final _auth = FirebaseAuth.instance;
    final translateController = Get.put(localizationController());
    final controller = Get.put(DashboardController());
    

    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.15,
            color: AppTheme.lightAppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .1,
                    child: Image.asset("assets/logo.jpeg")),
                const SizedBox(
                  height: 60,
                ),
                drawerButton(controller, "Fact Check".tr, Icons.message, 0, () {
                  controller.pageValue.value = 0;
                }),
                const SizedBox(
                  height: 20,
                ),
                drawerButton(controller, "User Reports".tr, Icons.post_add, 1, () async {
                  controller.pageValue.value = 1;
                  var token11 = await translateController.getToken();
                  print(token11);
                  
                }),
                drawerButton(controller, "History".tr, Icons.history, 2, () {
                  controller.pageValue.value = 2;
                }),
                drawerButton(controller, "Language".tr, Icons.translate, 3, () {
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
                drawerButton(controller, "Profile".tr, Icons.person, 3, () {
                  controller.pageValue.value = 3;
                }),
                const SizedBox(
                  height: 20,
                ),
                drawerButton(controller, "Logout".tr, Icons.login, 4, () async {
                  // await _auth.signOut();
                  translateController.removeToken();
                  //translateController.loadToken();
                  //Get.to(const LoginPage());
                }),
              ],
            ),
          ),
          Obx(() => Container(
              padding: const EdgeInsets.all(35),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.85,
              color: const Color.fromARGB(255, 241, 242, 248),
              child: getPage(controller.pageValue.value))),
        ],
      ),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return DashboardPage();
      case 1:
        return ReportPage();
      case 2:
        return  HistoryPage(); // history page
      case 3:
        return  const SettingPage();
      default:
        return DashboardPage();
    }
  }

  Widget drawerButton(DashboardController drawerController, String title,
      IconData icon, int index, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        drawerController.setActiveButton(index);
        onTap();
      },
      child: Obx(() => Container(
            decoration: BoxDecoration(
              color: drawerController.activeButtonIndex.value == index
                  ? const Color(0xffD18326)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.lightAppColors.background,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppTheme.lightAppColors.background,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
