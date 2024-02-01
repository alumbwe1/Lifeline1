import 'package:flutter/material.dart';
import 'package:lifeline/features/menu/feedback.dart';
import 'package:lifeline/features/menu/help.dart';
import '../menu/about.dart';
import '../menu/settings.dart';
import 'alerts_screens.dart';
import 'categories.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  // GlobalKey to open the drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Set the key here
      appBar: AppBar(
        title: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  // Open the drawer when the menu icon is tapped
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Image.asset(
                  'assets/me_icon.png',
                  height: 28,
                  width: 28,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : null,
                ),
              ),
            ),
            Spacer(),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AlertsPage(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/alerts.png',
                      height: 28,
                      width: 28,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'Having an Emergency?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              'Press the button below.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          Center(
            child: Text(
              'For help now.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: Image.asset(
                'assets/home.gif',
              ),
            ),
          ),
          Spacer(),
          InkWell(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesList(
                      services: [
                        ServiceItem(
                            image: 'assets/police-officer.png', name: 'Police'),
                        ServiceItem(
                            image: 'assets/svg.png', name: 'FireBrigade'),
                        ServiceItem(
                            image: 'assets/ambulance (1).png',
                            name: 'Ambulance'),
                        ServiceItem(
                            image: 'assets/support.png',
                            name: 'AdultChildCare'),
                        ServiceItem(
                            image: 'assets/more-information.png',
                            name: 'More Services'),
                      ],
                      onServiceSelected: (ServiceItem selectedService) {},
                    ),
                  ),
                );
                // ... (your existing code)
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 55,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'Quick Access',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  _buildDrawerItem(
                    icon: 'assets/info.png',
                    label: 'About Us',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/setting.png',
                    label: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/information.png',
                    label: 'Help',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/share.png',
                    label: 'Share',
                    onTap: () {
                      Navigator.pop(context);
                      _shareApp();
                    },
                  ),
                  _buildDrawerItem(
                    icon: 'assets/feedback.png',
                    label: 'Feedback',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildDrawerItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _buildDrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        height: 24,
        width: 24,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : null,
      ),
      title: Text(label),
      onTap: onTap,
    );
  }
}

void _shareApp() {
  Share.share(
    'Check out the Lifeline app! It helps you in emergencies.',
    subject: 'Lifeline App',
  );
}
