import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Order.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/Services/Orders.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

//This screen is used for checking all orders and its status

class DeliverOrdersScreen extends StatelessWidget {
  static String route = 'DOrdersScreen';
  @override
  Widget build(BuildContext context) {
    final OrdersService ordersservice = OrdersService();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Orders to deliver',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersservice.getallOrders(),
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
                      subtitle: listOfOrders[index].status != s_received
                          ? Text(listOfOrders[index].status,
                              style: TextStyle(
                                  color: listOfOrders[index].status == s_pending
                                      ? Colors.black
                                      : listOfOrders[index].status ==
                                              s_outfordelivery
                                          ? Colors.amber
                                          : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15))
                          : Container(),
                      trailing: listOfOrders[index].status == s_received
                          ? Text(listOfOrders[index].status,
                              style: TextStyle(
                                  color: listOfOrders[index].status == s_pending
                                      ? Colors.black
                                      : listOfOrders[index].status ==
                                              s_outfordelivery
                                          ? Colors.amber
                                          : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15))
                          : FlatButton(
                              color: mainColor,
                              onPressed: () {
                                ordersservice.editOrder(listOfOrders[index].id,
                                    listOfOrders[index].status);
                              },
                              child: Text('Change Status')),
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

  //this method is used to get the data from database and creating objects , better for coding

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
