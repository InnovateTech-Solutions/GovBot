
class UserModel {
  String? id;
  String name;
  String email;
  String password;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  UserModel.withEmailAndPassword({
    required this.email,
    required this.password,
  })  : id = null, // Optional fields can be left uninitialized or set to null
        name = "";

  tojason() {
    return {"username": name, "email": email, "password": password};
  }

  loginTojason() {
    return {"email": email, "password": password};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var userInfo = json['user_info'];  // Access the 'user_info' object

    return UserModel(
      id: userInfo['_id'],             // Mapping '_id' to 'id'
      name: userInfo['name'],          // Mapping 'name'
      email: userInfo['email'],        // Mapping 'email'
      password: '',                    // Password is not present in the provided JSON
    );
  }

  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //   final data = documentSnapshot.data()!;
  //   return UserModel(
  //       id: documentSnapshot.id,
  //       name: data['Name'],
  //       password: data['Password'],
  //       email: data['Email']);
  // }
}
