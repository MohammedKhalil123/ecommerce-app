import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class Orderdetails extends StatelessWidget {
  const Orderdetails({
    Key key,
    @required this.orderproducts,
  }) : super(key: key);

  final List<ProductItem> orderproducts;

  //Contains details of the order placed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mainColor,
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: orderproducts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 22,
                child: CircleAvatar(
                  radius: 20,
                  child: Container(),
                  backgroundColor: Color(int.parse(orderproducts[index].color)),
                ),
              ),
              title: Text(
                orderproducts[index].name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              subtitle: Text('qty:' + orderproducts[index].quantity.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              trailing: Text(
                '\$ ' + calculateCartItem(orderproducts[index]).toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            );
          }),
    );
  }

  int calculateCartItem(ProductItem cart) {
    return cart.price * cart.quantity;
  }
}
