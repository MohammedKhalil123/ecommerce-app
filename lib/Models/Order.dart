import 'package:ecommerce/Models/ProductItem.dart';
import 'package:flutter/cupertino.dart';

// to model and display list of orders when accessing the orders screen

class Order {
  String id;
  int total;
  List<ProductItem> products;
  String status;

  Order({
    @required this.id,
    @required this.total,
    @required this.products,
    @required this.status,
  });
}
