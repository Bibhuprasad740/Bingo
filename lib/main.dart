import 'package:bingo/controllers/auth_controller.dart';
import 'package:bingo/globals.dart';
import 'package:bingo/views/screens/game_screen.dart';
import 'package:bingo/views/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Globals.accent1,
          centerTitle: true,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
