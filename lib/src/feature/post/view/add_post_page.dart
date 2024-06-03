import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govbot/src/config/sizes/sizes.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/dashboard/pages/dashboard_drawe.dart';
import 'package:govbot/src/feature/login/model/login_form_model.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';
import 'package:govbot/src/feature/post/controller/post_controller.dart';
import 'package:govbot/src/feature/post/model/post_model.dart';
import 'package:govbot/src/feature/post/view/widget/add_post_form.dart';

class AddPostPAge extends StatelessWidget {
  const AddPostPAge({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppTheme.lightAppColors.primary.withOpacity(.3),
              AppTheme.lightAppColors.primary,
              AppTheme.lightAppColors.primary.withOpacity(.3),
              AppTheme.lightAppColors.primary,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppTheme.lightAppColors.background,
                      )),
                ],
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  width: context.screenWidth,
                  height: context.screenHeight * .8,
                  decoration: BoxDecoration(
                      color: AppTheme.lightAppColors.background,
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      children: [
                        headerText("Write Your Post".tr),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        AddPostForm(
                          formModel: FormModel(
                              controller: controller.description,
                              enableText: false,
                              hintText: "Post".tr,
                              invisible: false,
                              validator: (name) => controller.validName(name),
                              type: TextInputType.name,
                              inputFormat: null,
                              onTap: null),
                        ),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        appButton(context, "Post".tr, () {
                          if (controller.formkey.currentState!.validate()) {
                            controller.addPost(PostModel(
                                name: user.name,
                                userId: user.id!,
                                img: user.imageUrl!,
                                description: controller.description.text,
                                date: DateTime.now().toString(),
                                email: user.email));
                            print("add");
                            Get.to(const DashboardDrawer());
                            controller.description.clear();
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

headerText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
  );
}

GestureDetector appButton(BuildContext context, title, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: context.screenWidth * .8,
      height: context.screenHeight * .08,
      decoration: BoxDecoration(
          color: AppTheme.lightAppColors.primary,
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightAppColors.background)),
        ),
      ),
    ),
  );
}
