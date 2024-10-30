import 'package:flutter/material.dart';
import 'package:lifeline/features/menu/menu_list.dart';
import 'package:lifeline/features/screens/report_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'alerts_screens.dart';
import 'categories.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  // GlobalKey to open the drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Align(
              child: GestureDetector(
                onTap: () {
                  // Open the drawer when the menu icon is tapped
                  scaffoldKey.currentState?.openDrawer();
                },
                child: const Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Alumbwe Munali',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                          builder: (context) => const MenuList(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    'Are you in  Emergency?',
                    style: TextStyle(
                      fontSize: 24,
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
                  top: 10,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServicesList(
                            services: [
                              ServiceItem(
                                image: 'assets/police-officer.png',
                                name: 'Police',
                              ),
                              ServiceItem(
                                image: 'assets/svg.png',
                                name: 'FireBrigade',
                              ),
                              ServiceItem(
                                image: 'assets/ambulance (1).png',
                                name: 'Ambulance',
                              ),
                              ServiceItem(
                                image: 'assets/support.png',
                                name: 'AdultChildCare',
                              ),
                              ServiceItem(
                                image: 'assets/more-information.png',
                                name: 'More Services',
                              ),
                            ],
                            onServiceSelected: (ServiceItem selectedService) {},
                          ),
                        ),
                      );
                    },
                    child:  AvatarGlow(
                      glowShape: BoxShape.circle,
                      repeat: true,
                      glowColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.deepOrange,
                        child: Text(
                          'Click',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
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
        ),
      ),
    );
  }
}

