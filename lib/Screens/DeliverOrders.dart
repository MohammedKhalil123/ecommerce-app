import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class DeliverOrdersScreen extends StatelessWidget {
  static String route = 'DOrdersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Orders to deliver',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
