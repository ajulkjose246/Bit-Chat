import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailandPassword(
    BuildContext context,
    String email,
    String password,
    String firstname,
    String username,
    String secondname,
    Uint8List file,
  ) async {
    try {
      // Check if email is already in use
      QuerySnapshot emailSnapshot = await _firestore
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();

      if (emailSnapshot.docs.isNotEmpty) {
        throw Exception("Email already exists");
      }

      // Check if username is already in use
      QuerySnapshot usernameSnapshot = await _firestore
          .collection("Users")
          .where("username", isEqualTo: username)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        throw Exception("Username already exists");
      }

      // Sign up user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String imageUrl = await uploadImage(userCredential.user!.uid, file);

      // Save user info
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'firstName': firstname,
        'secondName': secondname,
        'profile': imageUrl,
        'username': username, // Add username to user document
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

  Future<DocumentSnapshot> getUserData(String uid) async {
    // Get user data from Firestore
    DocumentSnapshot userData =
        await _firestore.collection("Users").doc(uid).get();
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
