import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Screens/Home.dart';
import 'package:ecommerce/Screens/Settings.dart';
import 'package:flutter/material.dart';
import 'Screens/Login.dart';
import 'Screens/Signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.route,
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          SignupScreen.route: (context) => SignupScreen(),
          SettingsScreen.route: (context) => SettingsScreen(),
          HomeScreen.route: (context) => HomeScreen(),
        },
      ),
    );
  }
}
