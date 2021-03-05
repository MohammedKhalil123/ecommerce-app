import 'package:ecommerce/Models/ProductItem.dart';
import 'package:flutter/cupertino.dart';

class Cart {
  // to model and display list of products when accessing the cart screen
  List<ProductItem> products;

  Cart({
    @required this.products,
  });
}
