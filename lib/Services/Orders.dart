import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/constants.dart';

class OrdersService {
  final CollectionReference db =
      FirebaseFirestore.instance.collection('Orders');

  // all orders stream " for customers and driver_customer"
  Stream<QuerySnapshot> getOrders(String currentuserid) {
    return db.where('userId', isEqualTo: currentuserid).snapshots();
  }

  // all orders stream " for drivers"
  Stream<QuerySnapshot> getallOrders() {
    return db.snapshots();
  }

//adding the order to the database
  Future<void> addOrder(
    String currentuserid,
    List<ProductItem> productslist,
    int total,
  ) async {
    try {
      final CollectionReference pdb =
          FirebaseFirestore.instance.collection('Products');

      List<Map> _cartmap = [];
      for (int i = 0; i < productslist.length; i++) {
        Map temp = {
          pi_name: productslist[i].name,
          pi_color: productslist[i].color,
          pi_quantity: productslist[i].quantity,
          pi_price: productslist[i].price,
        };

        final QuerySnapshot productsnapshot = await pdb
            .where(p_name, isEqualTo: productslist[i].name)
            .limit(1)
            .get();

        productsnapshot.docs.forEach((snapshot) {
          List<DocumentSnapshot> documents = productsnapshot.docs;
          for (var document in documents) {
            document.reference.update({
              p_quantity: document.data()[p_quantity] - productslist[i].quantity
            });
          }
        });

        _cartmap.add(temp);
      }

      await db.add({
        o_userid: currentuserid,
        o_products: _cartmap,
        o_total: total,
        o_status: s_pending,
      });
    } catch (e) {
      print(e.toString());
    }
  }

// edit the order in database
  Future<void> editOrder(String orderId, String curStatus) async {
    String updatedstatus = '';
    if (curStatus == s_outfordelivery) {
      updatedstatus = s_received;
    } else {
      updatedstatus = s_outfordelivery;
    }
    await db.doc(orderId).update({o_status: updatedstatus});
  }
}
