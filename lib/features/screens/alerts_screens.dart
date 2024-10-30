import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../classes/alerts.dart';
import 'alerts_details_screen.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  List<Alerts> displayedAlerts = [];
  late final http.Client httpClient;

  @override
  void initState() {
    super.initState();
    httpClient = http.Client(); // Initialize httpClient
    _fetchAlerts(); // Fetch alerts when the page is initialized
  }

  @override
  void dispose() {
    httpClient.close(); // Close the http client when the widget is disposed
    super.dispose();
  }

  // Function to fetch alerts from the server
  Future<void> _fetchAlerts() async {
    try {
      final response = await httpClient.get(Uri.parse('http://10.0.2.2:8000/alerts/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          displayedAlerts =
              data.map((json) => Alerts.fromJson(json)).cast<Alerts>().toList();
        });
      } else {
        // Handle non-200 status code
        print('Failed to load alerts: ${response.statusCode}');
        showErrorMessage('Failed to load alerts. Please try again later.');
      }
    } catch (e) {
      // Handle generic errors
      print('Error loading alerts: $e');
      showErrorMessage('Error loading alerts. Please check your internet connection.');
    }
  }

  void showErrorMessage(String message) {
    // Use your preferred way to show error messages to users (e.g., toast, snackbar, alert dialog)
    // For example, using Flutter's built-in 'showSnackBar' method:
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alerts',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: displayedAlerts.map((alert) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlertsDetails(
                              alert: alert,
                            ),
                          ),
                        );
                      },
                      child: alertWidget(
                        username: alert.username,
                        userImage: alert.user_image,
                        details: alert.short_description,
                        date: _getCurrentDate(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container alertWidget({
    required String username,
    required String userImage,
    required String details,
    required String date,
  }) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userImage),
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              details,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            date,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String _getCurrentDate() {
  DateTime now = DateTime.now();
  return DateFormat('MMMM d, y').format(now);
}
