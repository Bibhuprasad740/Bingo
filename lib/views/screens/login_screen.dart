import 'package:bingo/globals.dart';
import 'package:bingo/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Globals.accent1.withOpacity(0.2),
              border: Border.all(
                width: 1,
                color: Globals.accent1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: size.height * 0.05),
                const Text(
                  'Bingo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) =>
                      Globals.authController.email.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  onChanged: (value) =>
                      Globals.authController.password.value = value,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      Globals.authController.email.value =
                          _emailController.text.trim();
                      Globals.authController.password.value =
                          _passwordController.text.trim();
                      await Globals.authController.signIn();
                    },
                    child: const Text('Login'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    Globals.authController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have account?'),
                    InkWell(
                      onTap: () => Get.to(() => const RegisterScreen()),
                      child: const Text(
                        ' Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
