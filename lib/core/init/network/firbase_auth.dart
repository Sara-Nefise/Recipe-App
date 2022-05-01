import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../exception/exception.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on FirebaseAuthException catch (e) {
      throw determineError(e);
    }
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(String email, String password) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("User").doc(user.user?.uid ?? "").set({
        'email': email,
      });

      return user.user;
    } on FirebaseAuthException catch (e) {
      throw determineError(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
