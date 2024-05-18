import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:govbot/src/core/auth_repo/auth_repo.dart';
import 'package:govbot/src/core/auth_repo/user_repo.dart';
import 'package:govbot/src/feature/login/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  late UserModel userModel;
  Rx<File?> image = Rx<File?>(null);

  @override
  void onReady() async {
    super.onReady();
    if (_authRepo.firebaseUser.value == null) {
      _authRepo.firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
      _authRepo.firebaseUser.bindStream(FirebaseAuth.instance.userChanges());
    }
  }

  void setImage(File? newImage) {
    image.value = newImage;
  }

  pickImage(userId) async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images').child('$userId.jpg');
    await storageReference.putFile(File(file.path));

    String imageUrl = await storageReference.getDownloadURL();
    setImage(File(file.path));
    update();
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('Users').doc(userId).update({
        'imageUrl': imageUrl,
      });
      QuerySnapshot postsQuery = await firestore
          .collection('Post')
          .where('id', isEqualTo: userId)
          .get();
      for (DocumentSnapshot postDoc in postsQuery.docs) {
        await postDoc.reference.update({
          'img': imageUrl,
        });
      }
      update();

      // ignore: empty_catches
    } catch (e) {}
  }

// user Details
  getUserDatar() {
    if (_authRepo.firebaseUser.value != null) {
      final email = _authRepo.firebaseUser.value!.email;
      if (email != null) {
        return _userRepo.getUserDetails(email);
      } else {
        Get.snackbar("Error", "Email is null");
      }
    } else {
      Get.snackbar("Error", "Firebase user is null");
    }
  }
}
