import 'package:flutter/cupertino.dart';

class Product {
  // to model and display list of products when accessing the home page
  String name;
  int quantity;
  int price;
  String type;
  String imageURL;
  bool onSale;
  List colors;
  int priceaftersale;

  Product({
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.type,
    @required this.colors,
    @required this.imageURL,
    @required this.onSale,
    this.priceaftersale,
  });
}
