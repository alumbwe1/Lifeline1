import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/urls.dart';
import '../../proveder.dart';
import '../menu/feedback/feedback_api.dart';
 // Update this import with the correct path to your URLs file
import 'package:provider/provider.dart';

import 'login_scren.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Lets Create\nyour Account\nnow.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: fullNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: confirmPasswordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => registerUser(context),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Have an account already? Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      final fullName = fullNameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      final response = await http.post(
        Uri.parse(users),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      if (response.statusCode == 201) {
        print(
            'User registered successfully. UserID: ${jsonDecode(response.body)['id']}');
        FeedbackApi.showMessage(
            context, 'User registered successfully', Colors.green);

        // Store the username using UsernameProvider
        final usernameProvider =
        Provider.of<UsernameProvider>(context, listen: false);
        usernameProvider.username = fullName;

        // Navigate to the login page upon successful registration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        // Handle registration failure
        print('Failed to register user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        FeedbackApi.showMessage(context, 'Failed to register user', Colors.red);
      }
    } catch (error) {
      // Handle error
      print('Error during registration: $error');
      FeedbackApi.showMessage(
          context, 'An error occurred. Please try again later.', Colors.red);
    }
  }
}
