import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/urls.dart';

class UserApi {
  static BuildContext? get context => null;

  static Future<String> getCsrfToken() async {
    try {
      final response = await http.get(Uri.parse(users));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['csrf_token'];
      } else {
        throw Exception('Failed to retrieve CSRF token');
      }
    } catch (error) {
      throw Exception('Failed to retrieve CSRF token: $error');
    }
  }

  static void showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: color,
      ),
    );
  }

  static Future<void> registerUser(String fullName, String email,
      String password, String confirmPassword) async {
    try {
      final csrfToken = await getCsrfToken();
      final userData = {
        'fullName': fullName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };

      final response = await http.post(
        Uri.parse(users),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRFToken': csrfToken,
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        // Handle successful response
        print(
            'User registered successfully. User ID: ${jsonDecode(response.body)['id']}');
        showMessage(context!, 'User registered successfully', Colors.green);
      } else {
        // Handle failure
        print('Failed to register user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle error
      print('Error registering user: $error');
    }
  }
}
