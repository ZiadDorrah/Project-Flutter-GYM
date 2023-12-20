// main.dart
import 'package:flutter/material.dart';
import 'package:project/pages/startPage.dart';
import 'package:project/pages/Auth/login.dart';
import 'package:project/pages/Auth/signup.dart';
import 'package:project/pages/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'final project',
      initialRoute: '/',
      routes: {
        '/': (context) => StartPage(), // Home route
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/homescreen': (context) => HomeScreen(username: 'admin'),
      },
    );
  }
}
