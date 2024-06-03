import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;

  String name;
  String email;
  String img;
  String description;
  String date;
  String userId;
  PostModel({
    required this.userId,
    this.id,
    required this.name,
    required this.email,
    required this.img,
    required this.description,
    required this.date,
  });
  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return PostModel(
      id: documentSnapshot.id,
      name: data['Name'],
      description: data['Description'],
      date: data['Date'],
      img: data["img"] ?? "",
      userId: data['id'],
      email: data['Email'],
    );
  }

  tojason() {
    return {
      "Name": name,
      "Email": email,
      "Description": description,
      "Date": date,
      "img": img,
      "id": userId,
    };
  }
}
