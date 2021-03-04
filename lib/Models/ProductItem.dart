import 'package:flutter/cupertino.dart';

class ProductItem {
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
