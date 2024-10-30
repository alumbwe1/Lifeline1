import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/urls.dart';

class FeedbackApi {
  static BuildContext? get context => null;

  static Future<String> getCsrfToken() async {
    try {
      final response = await http.get(Uri.parse(feedbacks));
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

  static Future<void> sendFeedback(
      String feedbackType, String description) async {
    try {
      final csrfToken = await getCsrfToken();
      final feedbackData = {
        'feedback_type': feedbackType,
        'description': description,
      };

      final response = await http.post(
        Uri.parse(feedbacks),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRFToken': csrfToken,
        },
        body: jsonEncode(feedbackData),
      );

      if (response.statusCode == 201) {
        // Handle successful response
        print(
            'Feedback sent successfully. Feedback ID: ${jsonDecode(response.body)['id']}');
        showMessage(context!, 'Feedback sent successfully', Colors.green);
      } else {
        // Handle failure
        print('Failed to send feedback. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle error
      print('Error sending feedback: $error');
    }
  }
}
