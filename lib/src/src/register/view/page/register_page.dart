import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/login/model/login_form_model.dart';
import 'package:govbot/src/src/login/model/user_model.dart';
import 'package:govbot/src/src/login/view/pages/login_form_widget.dart';
import 'package:govbot/src/src/login/view/pages/login_page.dart';
import 'package:govbot/src/src/register/controller/register_controller.dart';

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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          AppTheme.lightAppColors.background.withOpacity(.8)),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.asset("assets/logo.jpeg")),
                    Text(
                      "NEWS FACT CHECKER".tr,
                      style: TextStyle(
                        color: AppTheme.lightAppColors.primary  ,
                        fontSize: 24,
                        fontWeight: FontWeight.w300),
                        ),
                    const SizedBox(
                      height: 60,
                    ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.email,
                                enableText: false,
                                hintText: "Email".tr,
                                invisible: false,
                                validator: (email) =>
                                    controller.validEmail(email!),
                                type: TextInputType.emailAddress,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
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
                          height: MediaQuery.of(context).size.height * .03,
                        ),

                        FormWidget(
                            formModel: FormModel(
                                controller: controller.password,
                                enableText: false,
                                hintText: "Password".tr,
                                invisible: true,
                                validator: (password) =>
                                    controller.vaildatePassword(password!),
                                type: TextInputType.text,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              controller.createUser(
                                UserModel(
                                  name: controller.name.text.trim(),
                                  email: controller.email.text.trim(),
                                  password: controller.password.text.trim()
                                  )
                                  );
                            } else {}
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppTheme.lightAppColors.primary),
                            child: Center(
                              child: Text(
                                "Register".tr,
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
                              "Have Account ? Login ".tr,
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
        ],
      ),
    );
  }
}
