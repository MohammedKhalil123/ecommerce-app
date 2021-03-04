import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Widgets/CartViewBuilder.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String route = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    final Cart currentCart = Provider.of<CartProvider>(context).currentCart;
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
      body: CartViewBuilder(currentCart: currentCart),
    );
  }
}
