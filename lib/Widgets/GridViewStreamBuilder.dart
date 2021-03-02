import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/Product.dart';
import 'dart:async';

class CustomStreamBuilder extends StatefulWidget {
  const CustomStreamBuilder({
    Key key,
    @required this.snapshots,
  }) : super(key: key);

  final Stream<QuerySnapshot> snapshots;

  @override
  _CustomStreamBuilderState createState() => _CustomStreamBuilderState();
}

class _CustomStreamBuilderState extends State<CustomStreamBuilder>
    with AutomaticKeepAliveClientMixin<CustomStreamBuilder> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: widget.snapshots,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Product> list_Of_Products = [];
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((element) {
              list_Of_Products.add(
                Product(
                    priceaftersale: element.data()[p_onsale]
                        ? element.data()[p_priceaftersale]
                        : element.data()[p_price],
                    name: element.data()[p_name],
                    quantity: element.data()[p_quantity],
                    price: element.data()[p_price],
                    type: element.data()[p_type],
                    colors: element.data()[p_colors],
                    onSale: element.data()[p_onsale],
                    imageURL: element.data()[p_imageurl]),
              );
            });
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.0),
                itemCount: list_Of_Products.length,
                itemBuilder: (context, index) => Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Center(
                              child: Image.network(
                                '${list_Of_Products[index].imageURL}',
                              ),
                            ),
                          ),
                          list_Of_Products[index].onSale
                              ? Positioned(
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
                                  ))
                              : Container(),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.49,
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Colors.grey[300].withOpacity(0.7),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        list_Of_Products[index].name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ' \$${list_Of_Products[index].priceaftersale}',
                                        style: TextStyle(
                                            color: Colors.red[700],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      list_Of_Products[index].onSale
                                          ? Text(
                                              ' \$${list_Of_Products[index].price}',
                                              style: TextStyle(
                                                  color: Colors.red[700],
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Container(),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
          }
          return Center(
            child: Text('There is an error'),
          );
        });
  }
}
