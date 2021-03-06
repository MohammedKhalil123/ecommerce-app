import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Screens/DeliverOrders.dart';
import 'package:ecommerce/Screens/Home.dart';
import 'package:ecommerce/Screens/YourCart.dart';
import 'package:ecommerce/Screens/YourOrders.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.route,
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          SignupScreen.route: (context) => SignupScreen(),
          SettingsScreen.route: (context) => SettingsScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          OrdersScreen.route: (context) => OrdersScreen(),
          DeliverOrdersScreen.route: (context) => DeliverOrdersScreen(),
          CartScreen.route: (context) => CartScreen(),
        },
      ),
    );
  }
}
