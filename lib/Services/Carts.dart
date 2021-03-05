import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/constants.dart';

class CartService {
  final CollectionReference db = FirebaseFirestore.instance.collection('Carts');

  // get cart from database
  Future<Cart> getCart(User currentuser) async {
    List<ProductItem> allproductsfromdatabase = [];

    //query the database then model it in a formal manner
    await db
        .where('userId', isEqualTo: currentuser.id)
        .get()
        .then((docs) => docs.docs.forEach((element) {
              List<dynamic> moh = element.data()[c_products];
              moh.forEach((mapitem) {
                allproductsfromdatabase.add(ProductItem(
                    name: mapitem[pi_name],
                    quantity: mapitem[pi_quantity],
                    color: mapitem[pi_color],
                    price: mapitem[pi_price]));
              });
            }));
    return Cart(products: allproductsfromdatabase);
  }

  //query the database to get the doc , the nconverting the cart to list of maps to then update the data to the doc
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
        pi_name: _cart.products[i].name,
        pi_color: _cart.products[i].color,
        pi_quantity: _cart.products[i].quantity,
        pi_price: _cart.products[i].price,
      };

      _cartmap.add(temp);
    }

    db.doc(docid).update({
      c_products: _cartmap,
    });
  }

  //create the cart in database
  Cart createCart(User currentuser) {
    db.add({
      c_userid: currentuser.id,
      c_products: [],
    });

    return Cart(products: []);
  }
}
