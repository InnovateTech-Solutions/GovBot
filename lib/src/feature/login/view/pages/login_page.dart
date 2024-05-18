import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/sizes/sizes.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/login/controller/login_controller.dart';
import 'package:govbot/src/feature/login/model/login_form_model.dart';
import 'package:govbot/src/feature/login/view/pages/login_form_widget.dart';
import 'package:govbot/src/feature/register/view/page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formkey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.screenHeight * .17,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: context.screenWidth * .4,
                  height: context.screenHeight * .75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppTheme.lightAppColors.background),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Image.asset("assets/icon2.png"),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: context.screenWidth * .01,
                            ),
                            SizedBox(
                              width: context.screenWidth * .32,
                              child: FormWidget(
                                  formModel: FormModel(
                                      controller: controller.email,
                                      enableText: false,
                                      hintText: "Email".tr,
                                      invisible: false,
                                      validator: (email) =>
                                          controller.emailValid(email!),
                                      type: TextInputType.emailAddress,
                                      inputFormat: [],
                                      onTap: null)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        Row(
                          children: [
                            Icon(Icons.security),
                            SizedBox(
                              width: context.screenWidth * .01,
                            ),
                            SizedBox(
                              width: context.screenWidth * .32,
                              child: FormWidget(
                                  formModel: FormModel(
                                      controller: controller.password,
                                      enableText: false,
                                      hintText: "Password".tr,
                                      invisible: true,
                                      validator: (password) =>
                                          controller.vaildPassword(password!),
                                      type: TextInputType.text,
                                      inputFormat: [],
                                      onTap: null)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.screenHeight * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              controller.onLogin();
                            }
                          },
                          child: Container(
                            width: context.screenWidth * 0.2,
                            height: context.screenHeight * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppTheme.lightAppColors.primary),
                            child: Center(
                              child: Text(
                                "LOGIN".tr,
                                style: TextStyle(
                                    color: AppTheme.lightAppColors.background,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(RegisterPage());
                            },
                            child: Text(
                              "Don’t have an account? Sign up  ".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme.lightAppColors.primary),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                  width: context.screenWidth * .2,
                  height: context.screenHeight * .1,
                  child: Image.asset("assets/icon1.png")))
        ],
      ),
    );
  }
}
