import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static String route = 'OrdersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
