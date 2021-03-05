import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/Product.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Services/Carts.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class SelectedProductScreen extends StatefulWidget {
  final Product _selectedProduct;

  SelectedProductScreen(this._selectedProduct);

  @override
  _SelectedProductScreenState createState() => _SelectedProductScreenState();
}

/*
      This screen contains the selected product
      User has the ability to change colors and quantity based on the product current stock
      User can't order if it is out of stock or already added to cart

*/

class _SelectedProductScreenState extends State<SelectedProductScreen> {
  int counter = 1;
  final CartService cartService = CartService();
  bool isaddedtoCart = false;
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    final User currentuser = Provider.of<UserProvider>(context).user;
    final Cart currentCart = Provider.of<CartProvider>(context).currentCart;

    currentCart.products.forEach((element) {
      if (element.name == widget._selectedProduct.name) isaddedtoCart = true;
    });

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Hero(
                  tag: widget._selectedProduct.name,
                  child: Image.network(
                    widget._selectedProduct.imageURL,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              widget._selectedProduct.onSale
                  ? Positioned(
                      top: MediaQuery.of(context).size.width * 0.1,
                      right: 10,
                      child: CircleAvatar(
                        radius: 30,
                        child: Text(
                          'on Sale',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ))
                  : Container(),
              Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Builder(
                    builder: (context) => FlatButton(
                        height: MediaQuery.of(context).size.height * 0.15,
                        disabledColor: Colors.grey,
                        color: mainColor,
                        onPressed: isaddedtoCart ||
                                widget._selectedProduct.quantity == 0
                            ? null
                            : () {
                                ProductItem newProduct = ProductItem(
                                    name: widget._selectedProduct.name,
                                    quantity: counter,
                                    color: widget
                                        ._selectedProduct.colors[selectedindex],
                                    price: widget._selectedProduct.onSale
                                        ? widget._selectedProduct.priceaftersale
                                        : widget._selectedProduct.price);
                                final cprovider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);

                                cprovider.addProduct(newProduct);

                                cartService.editCart(
                                    currentCart, currentuser.id);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${widget._selectedProduct.name} has been successfully added to Cart'),
                                ));
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop();
                                });
                              },
                        child: Text(
                          isaddedtoCart
                              ? 'Item already added'
                              : widget._selectedProduct.quantity == 0
                                  ? 'Out of Stock'
                                  : 'Add to Cart',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  )),
              widget._selectedProduct.quantity == 0
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.075,
                      child: Transform.rotate(
                        angle: -math.pi / 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          color: Colors.red.withOpacity(0.7),
                          child: Text('OUT OF STOCK',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.white)),
                        ),
                      ))
                  : Container(),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    color: Colors.grey[300].withOpacity(0.7),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Builder(builder: (context) {
                              List<Widget> childrenofrow = [];
                              for (int i = 0;
                                  i < widget._selectedProduct.colors.length;
                                  i++) {
                                childrenofrow.add(Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: selectedindex == i
                                        ? Colors.blue
                                        : Colors.black,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedindex = i;
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Container(),
                                        backgroundColor: Color(int.parse(
                                            widget._selectedProduct.colors[i])),
                                      ),
                                    ),
                                  ),
                                ));
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: childrenofrow,
                              );
                            }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget._selectedProduct.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' \$${widget._selectedProduct.priceaftersale}',
                                style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              widget._selectedProduct.onSale
                                  ? Text(
                                      ' \$${widget._selectedProduct.price}',
                                      style: TextStyle(
                                          color: Colors.red[700],
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : Container(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                shape: CircleBorder(),
                                color: mainColor,
                                onPressed: isaddedtoCart ||
                                        widget._selectedProduct.quantity == 0
                                    ? null
                                    : () {
                                        setState(() {
                                          if (counter > 1) counter--;
                                        });
                                      },
                                child: Text('-',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Text(counter.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  )),
                              RaisedButton(
                                shape: CircleBorder(),
                                color: mainColor,
                                onPressed: isaddedtoCart ||
                                        widget._selectedProduct.quantity == 0
                                    ? null
                                    : () {
                                        setState(() {
                                          if (counter <
                                              widget._selectedProduct.quantity)
                                            counter++;
                                        });
                                      },
                                child: Text('+',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ]),
                  ))
            ],
          ),
        ));
  }
}
