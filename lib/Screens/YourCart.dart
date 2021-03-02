import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String route = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
