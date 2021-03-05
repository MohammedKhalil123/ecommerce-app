import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/ProductItem.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Services/Carts.dart';
import 'package:ecommerce/Services/Orders.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartViewBuilder extends StatelessWidget {
  const CartViewBuilder({
    Key key,
    @required this.currentCart,
  }) : super(key: key);

  final Cart currentCart;

  // widget used to view cart for two screens
  @override
  Widget build(BuildContext context) {
    final OrdersService orderservice = OrdersService();
    final cprovider = Provider.of<CartProvider>(context, listen: false);
    final CartService cartService = CartService();
    final User currentuser = Provider.of<UserProvider>(context).user;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.64,
          width: MediaQuery.of(context).size.width,
          child: currentCart.products.length == 0
              ? Center(
                  child: Text('Cart is Empty',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
              : ListView.builder(
                  itemCount: currentCart.products.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.9),
                            child: Icon(Icons.delete),
                          ),
                        ),
                        key: Key(currentCart.products[index].name),
                        onDismissed: (direction) {
                          cprovider.removeProduct(currentCart.products[index]);
                          cartService.editCart(
                              cprovider.currentCart, currentuser.id);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 22,
                            child: CircleAvatar(
                              radius: 20,
                              child: Container(),
                              backgroundColor: Color(
                                  int.parse(currentCart.products[index].color)),
                            ),
                          ),
                          title: Text(
                            currentCart.products[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                              'qty:' +
                                  currentCart.products[index].quantity
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          trailing: Text(
                            '\$ ' +
                                calculateCartItem(currentCart.products[index])
                                    .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Divider(thickness: 1),
                    ]);
                  }),
        ),
        Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
                height: MediaQuery.of(context).size.height * 0.15,
                color: mainColor,
                disabledColor: Colors.grey[400],
                onPressed: currentCart.products.length == 0
                    ? null
                    : () async {
                        await orderservice.addOrder(
                            currentuser.id,
                            cprovider.currentCart.products,
                            calculateTotal(cprovider.currentCart));

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Order has been placed successfully'),
                        ));
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });

                        cprovider.emptyCart();
                        cartService.editCart(
                            Cart(products: []), currentuser.id);
                      },
                child: Text('Order',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)))),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              color: Colors.grey,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Total',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          '\$ ' +
                              calculateTotal(cprovider.currentCart).toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ]),
            )),
      ]),
    );
  }

  int calculateCartItem(ProductItem cart) {
    return cart.price * cart.quantity;
  }

  int calculateTotal(Cart cart) {
    int total = 0;
    cart.products.forEach((element) {
      total += calculateCartItem(element);
    });
    return total;
  }
}
