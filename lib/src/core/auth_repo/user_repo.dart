// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:govbot/src/feature/login/controller/user_controller.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final userController = Get.put(UserController());

  final _db = FirebaseFirestore.instance;

  late UserModel userModel;

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).first;
    userModel = userdata;
    return userdata;
  }
}
