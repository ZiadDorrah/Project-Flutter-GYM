import 'package:flutter/material.dart';
import 'package:project/pages/startPage.dart';
import 'package:project/pages/Auth/login.dart';
import 'package:project/pages/Auth/signup.dart';
import 'package:project/pages/homeScreen.dart';
import 'package:project/pages/Auth/UserPreferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determine the initial route asynchronously
  String initialRoute = await determineInitialRoute();

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'final project',
      initialRoute: initialRoute,
      routes: {
        '/': (context) => StartPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/homescreen': (context) => HomeScreen(username: 'admin'),
      },
    );
  }
}

// Asynchronous function to determine the initial route
Future<String> determineInitialRoute() async {
  bool isLoggedIn = await UserPreferences.isLoggedIn();
  return isLoggedIn ? '/homescreen' : '/';
}
