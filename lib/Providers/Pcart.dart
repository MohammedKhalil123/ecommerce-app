import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  Cart currentCart = Cart(products: []);

  void addProduct(ProductItem productitem) {
    currentCart.products.add(productitem);
    notifyListeners();
  }

  void getCart(Cart cart) {
    currentCart = Cart(products: cart.products);
    notifyListeners();
  }

  void emptyCart() {
    currentCart = Cart(products: []);
  }
}
