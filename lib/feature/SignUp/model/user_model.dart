import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String password;
  String id;
  User({required this.id, required this.email, required this.password});
  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot.id,
      email: snapshot["email"],
      password: snapshot["password"],
    );
  }
}
