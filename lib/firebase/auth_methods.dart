// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donnors_choice/firebase/storage.dart';
import 'package:flutter/foundation.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> SignUP(
    String email,
    String password,
    String Name,
    String Phone,
    String Age,
    String Location,
    String BloodGroup,
    Uint8List file,
  ) async {
    String res = "Some Error Occured";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        String? url = await StorageMethods()
            .uploadImageToStorage("ProfileImages_$Name", file);

        await _firestore.collection("users").doc(user.uid).set({
          "Name": Name,
          "Phone": Phone,
          "Age": Age,
          "Location": Location,
          "BloodGroup": BloodGroup,
          "Email": email,
          "Photo": url,
          "organs": [],
        });
        res = "Signed Up Successfully";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        res = "The account already exists for that email.";
      }
    }
    return res;
  }

  Future<String> Login(String email, String password) async {
    String res = "Some Error Occured";
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        res = "Logged In Successfully";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        res = "Wrong password provided for that user.";
      }
    }
    return res;
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}
