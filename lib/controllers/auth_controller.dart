import 'package:bingo/views/screens/game_screen.dart';
import 'package:bingo/views/screens/login_screen.dart';
import 'package:bingo/views/screens/room_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../globals.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  var email = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var errorMessage = ''.obs;
  final _formKey = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(Globals.auth.currentUser);
    _user.bindStream(Globals.auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const RoomScreen());
    }
  }

  Future<void> signUp() async {
    isLoading.value = true;
    try {
      UserCredential result = await Globals.auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      if (result.user != null) {
        User user = result.user!;
      }
      Get.to(() => const RoomScreen());
      // Navigate to the home screen or another screen as appropriate
    } catch (e) {
      Get.snackbar('Error', e.toString());
      debugPrint('Catch block in AuthController().signUp(), ${e.toString()}');
    }
    isLoading.value = false;
  }

  Future<void> signIn() async {
    try {
      UserCredential result = await Globals.auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      if (result.user != null) {
        User user = result.user!;
      }
      Get.to(() => const RoomScreen());
      // Navigate to the home screen or another screen as appropriate
    } catch (e) {
      Get.snackbar('Error', e.toString());
      debugPrint('Catch block in AuthController().signIn(), ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await Globals.auth.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      debugPrint('Catch block in AuthController().signOut(), ${e.toString()}');
    }
  }
}
