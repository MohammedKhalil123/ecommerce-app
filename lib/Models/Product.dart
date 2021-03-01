import 'package:flutter/cupertino.dart';

class Product {
  String name;
  String quantity;
  String price;
  String type;
  String imageURL;
  List colors;

  Product({
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.type,
    @required this.colors,
    @required this.imageURL,
  });
}
