import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  //insatnce of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save user Info
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailandPassword(
    String email,
    String password,
    String firstname,
    String secondname,
    Uint8List file,
  ) async {
    try {
      //sign in
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String imageUrl = await uploadImage(userCredential.user!.uid, file);

      //save user Info
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'firstName': firstname,
        'secondName': secondname,
        'profile': imageUrl,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign user out

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<DocumentSnapshot> getUserData() async {
    // Get the current user
    User? user = _auth.currentUser;

    // Get user data from Firestore
    DocumentSnapshot userData =
        await _firestore.collection("Users").doc(user!.uid).get();
    return userData;
  }

  Future<String> uploadImage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
