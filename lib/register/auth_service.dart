import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //insatnce of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign user out

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
