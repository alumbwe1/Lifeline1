import 'package:flutter/material.dart';
import 'package:lifeline/features/screens/bottom_screen.dart';
import 'package:lifeline/features/screens/onboading_screen.dart';
import 'package:lifeline/features/screens/onboarding_screen.dart';
import 'package:lifeline/proveder.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'core/notifiers.dart';

void main() {
  runApp(
    // Wrap your app with MultiProvider to provide multiple providers
    MultiProvider(
      providers: [
        // Provide the username using ChangeNotifierProvider
        ChangeNotifierProvider(
          create: (context) => UsernameProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: isDark ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: const TestScreen(),
        );
      },
    );
  }
}
