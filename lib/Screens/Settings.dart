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
            title: Text(currentuser.email),
          ),
          ListTile(
            title: Text('Change Name'),
          ),
          ListTile(
            title: Text('Change email'),
          ),
          ListTile(
            title: Text('Change username'),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
              color: Colors.red,
            ),
            title: Text(
              'Sign out',
              style: TextStyle(color: Colors.red),
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
