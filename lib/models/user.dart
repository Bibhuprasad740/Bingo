import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name, email, profileImage;
  bool isAdmin;
  UserModel({
    required this.name,
    required this.email,
    required this.profileImage,
    this.isAdmin = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'profileImage': profileImage,
        'isAdmin': isAdmin,
      };
  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      email: snap['email'],
      profileImage: snap['profileImage'],
      isAdmin: snap['isAdmin'],
    );
  }
}
