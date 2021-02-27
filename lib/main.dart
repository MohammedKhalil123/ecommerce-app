import 'package:flutter/material.dart';
import 'Screens/Login.dart';
import 'Screens/Signup.dart';
import 'Screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        SignupScreen.route: (context) => SignupScreen(),
        HomeScreen.route: (context) => HomeScreen(),
      },
    );
  }
}
