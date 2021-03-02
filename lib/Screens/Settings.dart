import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Services/Auth.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login.dart';

class SettingsScreen extends StatelessWidget {
  static String route = 'SettingsScreen';
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    //to be implemented
    final User currentuser = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.mail,
              color: Colors.black,
            ),
            title: Text('Change email',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text('Change username',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
              color: Colors.red,
            ),
            title: Text(
              'Sign out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              await _authService.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
