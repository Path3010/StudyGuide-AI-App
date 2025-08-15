import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'welcomeScreen.dart';

void main() {
  runApp(const StudyGuideApp());
}

class StudyGuideApp extends StatelessWidget {
  const StudyGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Guide',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) => const HomescreenWidget(),
      },
    );
  }
}
