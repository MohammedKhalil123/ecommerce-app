import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Screens/YourCart.dart';
import 'package:ecommerce/Widgets/Drawer.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/Services/Products.dart';

//Home screen after loggin in contains mainly all the products in the app

class HomeScreen extends StatelessWidget {
  static String route = 'HomeScreen';

  final _authService = AuthService();
  final ProductServices _pservices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final User currentuser = Provider.of<UserProvider>(context).user;
    final Cart currentCart = Provider.of<CartProvider>(context).currentCart;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Shoes'),
              Tab(text: 'Trousers'),
              Tab(text: 'Jackets'),
              Tab(text: 'Shirts'),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: <Widget>[
            Stack(children: [
              currentCart.products.length != 0
                  ? Positioned(
                      right: 5,
                      bottom: 5,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black,
                        child: Text(currentCart.products.length.toString(),
                            style: TextStyle(color: Colors.yellow)),
                      ),
                    )
                  : Container(),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 150),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                                position: Tween(
                                        begin: Offset(1.0, 0.0),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: child);
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return CartScreen();
                          }));
                },
              ),
            ]),
          ],
          title: Text(
            'Hello, ${currentuser.username}',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: mainColor,
        ),
        drawer: SideDrawer(currentuser: currentuser, authService: _authService),
        body: TabBarView(
          children: [
            //get 4 stream builders for listening to changes in products while using the app
            _pservices.getShoes(),
            _pservices.getTrousers(),
            _pservices.getJackets(),
            _pservices.getShirts(),
          ],
        ),
      ),
    );
  }
}
