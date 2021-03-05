import 'package:flutter/cupertino.dart';

class ProductItem {
  // to model and display list of product items when adding them to the cart
  String name;
  int quantity;
  String color;
  int price;

  ProductItem({
    @required this.name,
    @required this.quantity,
    @required this.color,
    @required this.price,
  });
}
