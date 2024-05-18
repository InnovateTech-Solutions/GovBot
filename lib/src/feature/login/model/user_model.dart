import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String password;
  String phone;
  late String? imageUrl;

  UserModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.imageUrl,
  });

  tojason() {
    return {"Name": name, "Password": password, "Email": email, "phone": phone};
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserModel(
        id: documentSnapshot.id,
        name: data['Name'],
        password: data['Password'],
        email: data['Email'],
        imageUrl: data["imageUrl"] ?? "",
        phone: data["phone"] ?? "");
  }
}
