import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  Cart currentCart = Cart(products: []);

  void changeuser(ProductItem productitem) {
    currentCart.products.add(productitem);
    currentCart = Cart(products: currentCart.products);
    notifyListeners();
  }
}
