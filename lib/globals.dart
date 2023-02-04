import 'package:bingo/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Globals {
  //controllers
  static var authController = AuthController.instance;

  //firebase
  static var auth = FirebaseAuth.instance;
  static var firestore = FirebaseFirestore.instance;

  static const primaryColor = Colors.white;
  static const accent1 = Color.fromARGB(255, 1, 119, 5);
  static const accent2 = Colors.black;
  static const lightRed = Color.fromARGB(255, 221, 140, 134);
}
