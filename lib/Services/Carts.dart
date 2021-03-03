import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:provider/provider.dart';

class CartService {
  final db = FirebaseFirestore.instance.collection('Carts');

/*   Cart getCart(User currentuser){
    db.where('userId',isEqualTo: )
  } */

  void addtoCart() {}

  void removedfromCart() {}
}
