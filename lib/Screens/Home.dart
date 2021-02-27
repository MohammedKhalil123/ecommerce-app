import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String route = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hello, Mohammed',
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
                    Text('Mohammed@gmail.com'),
                    Text('Customer')
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
            ),
          ],
        ),
      ),
    );
  }
}
