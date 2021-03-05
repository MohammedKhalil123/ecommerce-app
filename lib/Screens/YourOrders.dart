import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Order.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Screens/YourOrderdetails.dart';
import 'package:ecommerce/Services/Orders.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// this screen is available for both types , to track orders and check details

class OrdersScreen extends StatelessWidget {
  static String route = 'OrdersScreen';
  @override
  Widget build(BuildContext context) {
    final User currentuser = Provider.of<UserProvider>(context).user;
    final OrdersService ordersservice = OrdersService();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersservice.getOrders(currentuser.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Order> listOfOrders = [];
            final allorders = snapshot.data.docs;
            allorders.forEach((element) {
              listOfOrders.add(Order(
                  id: element.id,
                  total: element.data()[o_total],
                  products: getProductitems(element.data()[o_products]),
                  status: element.data()[o_status]));
            });
            return ListView.builder(
                itemCount: listOfOrders.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 150),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                      position: Tween(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset.zero)
                                          .animate(animation),
                                      child: child);
                                },
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return Orderdetails(
                                      orderproducts:
                                          listOfOrders[index].products);
                                }));
                      },
                      leading: Text('Order ID :',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      title: Text('${listOfOrders[index].id}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      subtitle: Text(
                          '\$ ' + listOfOrders[index].total.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      trailing: Text(listOfOrders[index].status,
                          style: TextStyle(
                              color: listOfOrders[index].status == s_pending
                                  ? Colors.black
                                  : listOfOrders[index].status ==
                                          s_outfordelivery
                                      ? Colors.amber
                                      : Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      dense: true,
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ]);
                });
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  List<ProductItem> getProductitems(List<dynamic> snapdata) {
    List<ProductItem> allproductsfromdatabase = [];

    snapdata.forEach((element) {
      allproductsfromdatabase.add(ProductItem(
          name: element[pi_name],
          quantity: element[pi_quantity],
          color: element[pi_color],
          price: element[pi_price]));
    });
    return allproductsfromdatabase;
  }
}
