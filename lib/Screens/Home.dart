import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Screens/Login.dart';
import 'package:ecommerce/Screens/Settings.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Services/Auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String route = 'HomeScreen';

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final User currentuser = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: <Widget>[
          Stack(children: [
            Positioned(
              right: 5,
              bottom: 5,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red[500],
                child: Text('3', style: TextStyle(color: Colors.black)),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {
                // do something
              },
            ),
          ]),
        ],
        title: Text(
          'Hello, ${currentuser.username}',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: mainColor,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: mainColor,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Mohammed',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(currentuser.email),
                    Text(currentuser.type)
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
              title: Text('Your Cart'),
              trailing: CircleAvatar(
                radius: 15,
                backgroundColor: mainColor,
                child: Text(
                  '3',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                size: 30,
              ),
              title: Text('Your Orders'),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.directions_car,
                size: 30,
              ),
              title: Text('Orders to deliver'),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
              ),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.route);
              },
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
      ),
    );
  }
}
