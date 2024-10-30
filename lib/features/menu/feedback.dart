import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import '../../core/urls.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String _selectedFeedbackType = 'General Feedback';
  final TextEditingController _feedbackController = TextEditingController();

  Future<String> getCsrfToken() async {
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

  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: color,
      ),
    );
  }

  Future<void> sendFeedback() async {
    try {
      final csrfToken = await getCsrfToken();
      final feedbackData = {
        'feedback_type': _selectedFeedbackType,
        'description': _feedbackController.text,
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
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Feedback sent successfully. Feedback ID: ${responseData['id']}');
        showMessage('Feedback sent successfully', Colors.green);

        // Clear the text fields after successful submission
        setState(() {
          _selectedFeedbackType = 'General Feedback';
          _feedbackController.clear();
        });
      } else {
        showMessage('Failed to send feedback. Please try again.', Colors.red);
        print('Failed to send feedback. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      showMessage('Error sending feedback. Please try again.', Colors.red);
      print('Error sending feedback: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blue),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedFeedbackType,
                  onChanged: (value) {
                    setState(() {
                      _selectedFeedbackType = value!;
                    });
                  },
                  items:
                      ['General Feedback', 'Bug Report', 'Suggestion', 'Other']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Feedback Type',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _feedbackController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Describe your issue or share your thoughts...',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.orange,
                ),
                child: TextButton(
                  onPressed: () {
                    sendFeedback(); // Call the sendFeedback function
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
