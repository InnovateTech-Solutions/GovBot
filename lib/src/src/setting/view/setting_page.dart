import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/login/model/login_form_model.dart';
import 'package:govbot/src/src/login/model/user_model.dart';
import 'package:govbot/src/src/login/view/pages/login_form_widget.dart';
import 'package:govbot/src/src/setting/controller/setting_cotroller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final SettingController controller = Get.put(SettingController());

  @override
  void initState() {
    super.initState();
    controller.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;

              return Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.lightAppColors.background.withOpacity(.8)),
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      Text(
                        "Profile".tr,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .03),
                      FormWidget(
                          formModel: FormModel(
                              controller: controller.email,
                              enableText: true,
                              hintText: "Email".tr,
                              invisible: false,
                              validator: controller.validEmail,
                              type: TextInputType.emailAddress,
                              inputFormat: [],
                              onTap: null)),
                      SizedBox(height: MediaQuery.of(context).size.height * .03),
                      FormWidget(
                          formModel: FormModel(
                              controller: controller.name,
                              enableText: false,
                              hintText: "Name".tr,
                              invisible: false,
                              validator: controller.validName,
                              type: TextInputType.text,
                              inputFormat: [],
                              onTap: null)),
                      SizedBox(height: MediaQuery.of(context).size.height * .05),
                      GestureDetector(
                        onTap: () {
                          if (controller.formkey.currentState!.validate()) {
                            controller.updateUserData(userData.id);
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .08,
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
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
