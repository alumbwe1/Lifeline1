import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'about.dart';
import 'feedback.dart';
import 'help.dart';
import 'settings.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Menu',
          style: TextStyle(fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuItem(context, 'About Us', 'assets/info.png', const AboutUsPage()),
            _buildMenuItem(context, 'Settings', 'assets/setting.png', const SettingsPage()),
            _buildMenuItem(context, 'Help', 'assets/information.png', const HelpPage()),
            _buildMenuItem(context, 'Share', 'assets/share.png', SharePage()),
            _buildMenuItem(context, 'Feedback', 'assets/feedback.png', const FeedbackPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String imagePath, Widget destinationPage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // Navigate to the selected page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        leading: Image.asset(imagePath, width: 24, height: 24),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _shareApp(context);
          },
          child: const Text('Share App'),
        ),
      ),
    );
  }

  void _shareApp(BuildContext context) {
    Share.share(
      'Check out the Lifeline app! It helps you in emergencies.',
      subject: 'Lifeline App',
    );
  }
}
