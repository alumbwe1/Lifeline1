import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lifeline/features/menu/menu_list.dart';
import 'package:lifeline/features/screens/addscreens/choose_contacts_screen.dart';
import 'package:lifeline/features/screens/alerts_screens.dart';
import 'package:lifeline/features/screens/chat/chat_screen.dart';
import 'package:lifeline/features/screens/home_screen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChatListPage(),
    const ChooseContactCategory(),
    const AlertsPage(),
    const MenuList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          gap: 2,
          activeColor: Colors.white,
          color: Colors.grey,
          iconSize: 27,
          tabBorderRadius: 15,
          tabBackgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
          tabs: const [
            GButton(

              icon: Icons.home_outlined, // Use an IconData for the icon
              text: 'Home',
            ),
            GButton(
              icon: Icons.chat_bubble_outline_rounded, // Use an IconData for the icon
              text: 'Chat',
            ),
            GButton(
              icon: Icons.people_alt_outlined, // Use an IconData for the icon
              text: 'Contacts',
            ),
            GButton(
              icon: Icons.notifications_none_rounded, // Use an IconData for the icon
              text: 'Alerts',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
