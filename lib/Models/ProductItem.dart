import 'package:ecommerce/Models/Product.dart';
import 'package:flutter/cupertino.dart';

class ProductItem {
  Product p_Name;
  int quantity;
  String color;

  ProductItem({
    @required this.p_Name,
    @required this.quantity,
    @required this.color,
  });
}
