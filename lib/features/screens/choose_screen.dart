import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeline/features/auth/login_scren.dart';
import 'package:lifeline/features/auth/sign_up.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Lifeline.png', height: 60, width: 50),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset('assets/signup.png', height: 150, width: 150), // Replace with your convincing image
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Join Lifeline\nfor immediate\n help and support.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(),),);
            },
            child: Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(40)
              ),
              child: const Center(child: Text('Create Account',style: TextStyle(fontSize: 15,color: Colors.white,),),),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage(),),);
            },
            child: const Text(
              'Have an account already? Login',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
