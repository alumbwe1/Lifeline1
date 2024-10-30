import 'package:flutter/material.dart';
import 'package:lifeline/features/screens/bottom_screen.dart';
import 'package:lifeline/features/screens/home_screen.dart';


import 'package:cached_network_image/cached_network_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
          () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
              'https://global-uploads.webflow.com/635b437f2bca81033474f122/635bfb47e44c8252a104c922_website%20logo.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 16),
            const Text(
              'Lifeline',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
