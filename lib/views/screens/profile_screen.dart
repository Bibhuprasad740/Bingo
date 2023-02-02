import 'package:bingo/globals.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: Globals.authController.signOut,
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
