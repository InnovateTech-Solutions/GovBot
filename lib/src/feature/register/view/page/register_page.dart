import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/sizes/sizes.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/login/model/login_form_model.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';
import 'package:govbot/src/feature/login/view/pages/login_form_widget.dart';
import 'package:govbot/src/feature/login/view/pages/login_page.dart';
import 'package:govbot/src/feature/register/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
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
                Container(
                  padding: const EdgeInsets.all(20),
                  width: context.screenWidth * .4,
                  height: context.screenHeight * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          AppTheme.lightAppColors.background.withOpacity(.8)),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                            height: context.screenHeight * 0.2,
                            child: Image.asset("assets/icon2.png")),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.email,
                                enableText: false,
                                hintText: "Email",
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
                                hintText: "Name",
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
                                hintText: "Phone",
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
                          height: context.screenHeight * .03,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.password,
                                enableText: false,
                                hintText: "Password",
                                invisible: true,
                                validator: (password) =>
                                    controller.vaildatePassword(password!),
                                type: TextInputType.text,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: context.screenHeight * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              controller.onSignup(UserModel(
                                  name: controller.name.text.trim(),
                                  email: controller.email.text.trim(),
                                  password: controller.password.text.trim(),
                                  imageUrl: '',
                                  phone: controller.phone.text.trim()));
                              //  UserController.instance.logIn();
                            } else {}
                          },
                          child: Container(
                            width: context.screenWidth * 0.2,
                            height: context.screenHeight * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppTheme.lightAppColors.primary),
                            child: Center(
                              child: Text(
                                "Register",
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
                              Get.to(LoginPage());
                            },
                            child: Text(
                              "Have Account ? Login ",
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
