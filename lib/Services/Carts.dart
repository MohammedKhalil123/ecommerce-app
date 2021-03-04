import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/constants.dart';

class CartService {
  final CollectionReference db = FirebaseFirestore.instance.collection('Carts');

  Future<Cart> getCart(User currentuser) async {
    List<ProductItem> allproductsfromdatabase = [];

    await db
        .where('userId', isEqualTo: currentuser.id)
        .get()
        .then((docs) => docs.docs.forEach((element) {
              List<dynamic> moh = element.data()[c_products];
              moh.forEach((mapitem) {
                allproductsfromdatabase.add(ProductItem(
                    name: mapitem['Name'],
                    quantity: mapitem['Qty'],
                    color: mapitem['Color'],
                    price: mapitem['Price']));
              });
            }));
    print(allproductsfromdatabase[0].name);
    return Cart(products: allproductsfromdatabase);
  }

  void editCart(Cart _cart, String currentuserid) async {
    String docid = '';
    await db
        .where('userId', isEqualTo: currentuserid)
        .limit(1)
        .get()
        .then((doc) {
      docid = doc.docs[0].id;
    });

    List<Map> _cartmap = [];
    for (int i = 0; i < _cart.products.length; i++) {
      Map temp = {
        'Name': _cart.products[i].name,
        'Color': _cart.products[i].color,
        'Qty': _cart.products[i].quantity,
        'Price': _cart.products[i].price,
      };

      _cartmap.add(temp);
    }

    db.doc(docid).set({
      c_userid: currentuserid,
      c_products: _cartmap,
    });
  }

  Cart createCart(User currentuser) {
    db.add({
      c_userid: currentuser.id,
      c_products: [],
    });

    return Cart(products: []);
  }
}
