import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/notifiers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences _prefs;
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load theme settings from shared preferences
  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkModeEnabled = _prefs.getBool('isDarkModeEnabled') ?? false;
    });
  }

  // Save theme settings to shared preferences
  Future<void> _saveSettings() async {
    await _prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Settings',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isDarkModeNotifier.value = !isDarkModeNotifier.value;
                  isDarkModeEnabled = !isDarkModeEnabled;
                  _saveSettings(); // Save theme settings
                });
                // Toggle between dark and light mode based on the 'isDarkModeEnabled' value.
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'Dark Mode'
                          : 'Light Mode',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Icon(
                      isDarkModeNotifier.value
                          ? Icons.brightness_2
                          : Icons.brightness_6,
                      color: Colors.black87,
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
