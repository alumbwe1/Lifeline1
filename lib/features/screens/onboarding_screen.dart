import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:lifeline/features/auth/login_scren.dart';
import 'package:lifeline/features/screens/choose_screen.dart';

import 'bottom_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Set your desired background color
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index.toDouble();
                  });
                },
                children: const [
                  OnboardingPage(
                    backgroundColor: Colors.red,
                    image: 'assets/c2.png',
                    title: 'Enjoy chatting\nall time',
                    content:
                    'Connect with counselors and emergency stations to ensure your safety and well-being.',
                  ),
                  OnboardingPage(
                    backgroundColor: Colors.red,
                    image: 'assets/call24.png',
                    title: 'Call for Help\n24/7',
                    content:
                    'Emergency situations require immediate attention. Our app provides 24/7 support.',
                  ),
                  OnboardingPage(
                    backgroundColor: Colors.red,
                    image: 'assets/a.png',
                    title: 'Anytime\nEmergency',
                    content:
                    'Experience peace of mind knowing that help is just a tap away, anytime you need it.',
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: _currentPage.toInt(),
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.white70, // Inactive dot color
                      activeColor: Colors.yellow, // Active dot color
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the next screen when 'Arrow Forward' is tapped
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to MyHomePage when on the last screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ChooseScreen()),
                        );
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.yellow,
                      ),
                      child: const Center(child: Icon(Icons.arrow_forward_ios),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  final Color backgroundColor;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/Lifeline.png',
                  height: 80,
                  width: 80,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Navigate to MyHomePage when 'Skip' is tapped
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: 18,),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Image.asset(
                image,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

