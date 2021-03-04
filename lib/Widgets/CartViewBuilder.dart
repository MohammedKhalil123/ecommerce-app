import 'package:ecommerce/Models/Cart.dart';
import 'package:flutter/material.dart';

class CartViewBuilder extends StatelessWidget {
  const CartViewBuilder({
    Key key,
    @required this.currentCart,
  }) : super(key: key);

  final Cart currentCart;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: currentCart.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(currentCart.products[index].quantity.toString()),
            title: Text(currentCart.products[index].name),
            trailing: Text(currentCart.products[index].price.toString()),
          );
        });
  }
}
