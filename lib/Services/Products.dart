import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:flutter/material.dart';

class ProductServices {
  final db = FirebaseFirestore.instance.collection('Products');

  Widget getJackets() {
    final Stream<QuerySnapshot> snapshots =
        db.where('type', isEqualTo: 'Jacket').get().asStream();

    return StreamBuilder(
        stream: snapshots,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Product> list_Of_Products = [];
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((element) {
              list_Of_Products.add(Product(
                  name: element.data()['Name'],
                  quantity: element.data()['Quantity'],
                  price: element.data()['Price'],
                  type: element.data()['type'],
                  colors: element.data()['Colors'],
                  imageURL: element.data()['ImageURL']));
            });
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: list_Of_Products.length,
                itemBuilder: (context, index) => Card(
                    elevation: 10,
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: Center(
                            child: Image.network(
                                '${list_Of_Products[index].imageURL}'),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 10,
                            child: CircleAvatar(
                              radius: 20,
                              child: Text(
                                'on Sale',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            )),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.49,
                            height: MediaQuery.of(context).size.height * 0.1,
                            color: Colors.red[300].withOpacity(0.5),
                            child: Center(
                              child: Text(
                                list_Of_Products[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )));
          }
          return Center(child: Text('yikes'));
        });
  }

  Widget getTrousers() {
    return Text('Trousers');
  }

  Widget getShirts() {
    return Text('Shirts');
  }

  Widget getShoes() {
    return Text('Shoes');
  }
}
