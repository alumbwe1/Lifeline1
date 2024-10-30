import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lifeline/core/urls.dart';
import 'dart:convert';

import '../../core/my_textfield.dart';

class ReportScreen extends StatefulWidget {
  final String name;

  const ReportScreen({Key? key, required this.name}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emergencyTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
  bool _isSendingReport = false;
  Future<void> sendReport (BuildContext context) async {
    try {
      setState(() {
        _isSendingReport = true;
      });

      // Get the police station ID
      final policeStationId = await getPoliceStationId(widget.name);

      // Prepare data for the report
      Map<String, dynamic> reportData = {
        'location': locationController.text,
        'description': descriptionController.text,
        'full_name': fullNameController.text,
        'contact_info': contactInfoController.text,
        'emergency_type': emergencyTypeController.text,
        'police_station': policeStationId.toString(),
      };

      // Send the report data to the server
      final response = await http.post(
        Uri.parse(report), // Replace with your server endpoint
        body: reportData,
      );

      if (response.statusCode == 201) {
        print('Report sent successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report sent successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Failed to send report. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send report. Status code: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle exceptions or display an error message
      print('Error sending report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error sending report'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSendingReport = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyTextField(
                      obscureText: false,
                      controller: fullNameController,
                      labelText: 'Full Name',
                    ),
                    const SizedBox(height: 10,),
                    MyTextField(
                      obscureText: false,
                      controller: locationController,
                      labelText: 'Location',
                    ),
                    const SizedBox(height: 10,),
                    MyTextField(
                      obscureText: false,
                      controller: emergencyTypeController,
                      labelText: 'Emergency Type',
                    ),
                    const SizedBox(height: 10,),
                    MyTextField(
                      obscureText: false,
                      controller: descriptionController,
                      labelText: 'Description',
                    ),
                    const SizedBox(height: 10,),
                    MyTextField(
                      obscureText: false,
                      controller: contactInfoController,
                      labelText: 'Contact info',
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      readOnly: true,
                      controller: TextEditingController(text: widget.name),
                      decoration: const InputDecoration(
                        labelText: 'Police Station',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        sendReport(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: _isSendingReport
                          ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                          : const Text(
                        'Send Report',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<int?> getPoliceStationId(String policeStationName) async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/police-stations/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      for (final station in data) {
        if (station['name'] == policeStationName) {
          return station['id'];
        }
      }

      // If the police station is not found, you may handle it as needed.
      print('Police station not found');
      return null;
    } else {
      // Handle the error if the request to fetch police stations fails
      print('Failed to fetch police stations. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Handle exceptions or display an error message
    print('Error fetching police stations: $e');
    return null;
  }
}


