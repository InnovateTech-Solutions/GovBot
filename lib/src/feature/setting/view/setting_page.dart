import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govbot/src/config/sizes/sizes.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/core/auth_repo/auth_repo.dart';
import 'package:govbot/src/feature/login/model/login_form_model.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';
import 'package:govbot/src/feature/login/view/pages/login_form_widget.dart';
import 'package:govbot/src/feature/setting/controller/profile_controller.dart';
import 'package:govbot/src/feature/setting/controller/setting_cotroller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final user = Get.put(ProfileController());
  @override
  void initState() {
    user.getUserDatar();
    super.initState();
  }

  final _authRepo = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    final email = _authRepo.firebaseUser.value!.email;
    final controller = Get.put(SettingController());

    return FutureBuilder(
        future: controller.getUserDetails(email!),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              UserModel userData = snapShot.data as UserModel;

              return Container(
                padding: EdgeInsets.all(20),
                width: context.screenWidth * .4,
                height: context.screenHeight * .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.lightAppColors.background.withOpacity(.8)),
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      Text(
                        "SETTINGS".tr,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: context.screenHeight * .03,
                      ),
                      FormWidget(
                          formModel: FormModel(
                              controller: controller.email,
                              enableText: true,
                              hintText: "Email".tr,
                              invisible: false,
                              validator: (email) =>
                                  controller.validEmail(email!),
                              type: TextInputType.emailAddress,
                              inputFormat: [],
                              onTap: null)),
                      SizedBox(
                        height: context.screenHeight * .03,
                      ),
                      FormWidget(
                          formModel: FormModel(
                              controller: controller.name,
                              enableText: false,
                              hintText: "Name".tr,
                              invisible: false,
                              validator: (email) =>
                                  controller.validName(email!),
                              type: TextInputType.emailAddress,
                              inputFormat: [],
                              onTap: null)),
                      SizedBox(
                        height: context.screenHeight * .03,
                      ),
                      FormWidget(
                          formModel: FormModel(
                              controller: controller.phone,
                              enableText: false,
                              hintText: "Phone".tr,
                              invisible: false,
                              validator: (email) =>
                                  controller.vaildPhoneNumber(email!),
                              type: TextInputType.emailAddress,
                              inputFormat: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onTap: null)),
                      SizedBox(
                        height: context.screenHeight * .05,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.formkey.currentState!.validate()) {
                            controller.updateUserData(userData.id);
                          } else {}
                        },
                        child: Container(
                          width: context.screenWidth,
                          height: context.screenHeight * .08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppTheme.lightAppColors.primary),
                          child: Center(
                            child: Text(
                              "UPDATE".tr,
                              style: TextStyle(
                                  color: AppTheme.lightAppColors.background,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapShot.hasError) {
              return Center(child: Text('Error${snapShot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Text tabelHeaderText(title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppTheme.lightAppColors.bordercolor)),
    );
  }
}
