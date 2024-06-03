import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/feature/post/model/post_model.dart';

class PostController extends GetxController {
  final _db = FirebaseFirestore.instance;
  RxInt postLength = 0.obs;
  RxInt userPostLength = 0.obs;

  final description = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<List<Map<String, dynamic>>> fetchAllPost() async {
    List<Map<String, dynamic>> post = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Post')
          .orderBy('Date',
              descending: true) // Order by datetime field in descending order
          .get();

      for (var doc in result.docs) {
        post.add(doc.data());
      }
      // ignore: empty_catches
    } catch (e) {}

    return post;
  }

  Future<void> addPost(PostModel post) async {
    await _db
        .collection("Post")
        .add(post.tojason())
        .whenComplete(
          () => Get.snackbar("Success", "Post Added Successfully",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppTheme.lightAppColors.background,
              backgroundColor: Colors.green),
        )
        .catchError((error) {
      Get.snackbar(error.toString(), "Something went wrong , try agin",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppTheme.lightAppColors.background,
          backgroundColor: Colors.red);
      throw error;
    });
  }

  validName(String? name) {}
}
