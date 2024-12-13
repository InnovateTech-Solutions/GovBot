import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/login/controller/login_controller.dart';
import 'package:govbot/src/src/login/model/login_form_model.dart';
import 'package:govbot/src/src/login/view/pages/login_form_widget.dart';
import 'package:govbot/src/src/register/view/page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formkey = GlobalKey<FormState>();

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .17,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppTheme.lightAppColors.background),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Image.asset("assets/logo.jpeg"),
                    Text(
                      "NEWS FACT CHECKER".tr,
                      style: TextStyle(
                        color: AppTheme.lightAppColors.primary  ,
                        fontSize: 24,
                        fontWeight: FontWeight.w300),
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .32,
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
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Row(
                      children: [
                        Icon(Icons.security),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .32,
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
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          controller.onLogin();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * .05,
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
    );
  }
}
