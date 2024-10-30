import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:hive/hive.dart';

class CustomStationCard extends StatelessWidget {
  final String name;
  final String image;
  final String phoneNumber;
  final VoidCallback onPressed;

  const CustomStationCard({
    Key? key,
    required this.name,
    required this.image,
    required this.phoneNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        height: 300,

        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purpleAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AvatarGlow(
                            glowShape: BoxShape.circle,
                            glowColor: Colors.blue,
                            repeat: true,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: CachedNetworkImageProvider(
                              image), // Use CachedNetworkImageProvider
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 55),
                    ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 40,
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Request Service',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
