import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceRequestBottomSheet extends StatelessWidget {
  final String phoneNumber;
  final String location;

  const ServiceRequestBottomSheet({
    Key? key,
    required this.phoneNumber,
    required this.location,
    required Null Function() onPressed,
  }) : super(key: key);

  void _makePhoneCall() async {
    try {
      bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      if (res != null && !res) {
        print('Failed to make the phone call.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _openMessagingApp() async {
    final String uri = 'sms:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print('Could not launch messaging app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Service Requested',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset(
                  'assets/gps.png',
                  height: 60,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : null,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/information-button.png',
                      height: 60,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : null,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        ' Available 24/7 for any emergency.',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ElevatedButton(
                onPressed: _makePhoneCall,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: SizedBox(
                  height: 55, // Increase the height of the button
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/phone-call.png',
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Call Now',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              'OR',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openMessagingApp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              child: SizedBox(
                height: 55, // Increase the height of the button
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/messenger.png',
                      height: 40,
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Text Us',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
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
