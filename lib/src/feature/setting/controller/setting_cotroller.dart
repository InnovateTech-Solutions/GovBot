import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';

class SettingController extends GetxController {
  final email = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final _db = FirebaseFirestore.instance;
  final formkey = GlobalKey<FormState>();

  final confirmPassword = TextEditingController();

  validEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return "Email is not valid";
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!) && phoneNumber.length >= 9) {
      return null;
    }
    return "Invalid Phone number";
  }

  validName(String? address) {
    if (address!.isEmpty) {
      return "Username is not valid";
    }
    return null;
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).first;
    this.email.text = userdata.email;
    name.text = userdata.name;
    phone.text = userdata.phone;
    name.text = userdata.name;
    return userdata;
  }

  Future<void> updateUserData(userId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Users').doc(userId).update({
        'Name': name.text,
        'phone': phone.text,
      });
      Get.snackbar("Success", " Account  Updated Successfullly",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.green);
     } catch (e) {
      print(e);
    }
  }
}
