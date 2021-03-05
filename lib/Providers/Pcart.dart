import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  Cart currentCart = Cart(products: []);

//Mainly used when adding the product to the provider
  void addProduct(ProductItem productitem) {
    currentCart.products.add(productitem);
    notifyListeners();
  }

//Mainly used when removing the product from the provider
  void removeProduct(ProductItem productitem) {
    currentCart.products.remove(productitem);
    notifyListeners();
  }

//Mainly used when logging in and loading from the database to the provider
  void getCart(Cart cart) {
    currentCart = Cart(products: cart.products);
    notifyListeners();
  }

  //Mainly used when ordering to empty the cart and when logging out
  void emptyCart() {
    currentCart = Cart(products: []);
    notifyListeners();
  }
}
