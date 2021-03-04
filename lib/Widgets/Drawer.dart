import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Screens/DeliverOrders.dart';
import 'package:ecommerce/Screens/Login.dart';
import 'package:ecommerce/Screens/YourCart.dart';
import 'package:ecommerce/Screens/YourOrders.dart';
import 'package:ecommerce/Screens/Settings.dart';
import 'package:ecommerce/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({
    Key key,
    @required this.currentuser,
    @required AuthService authService,
  })  : _authService = authService,
        super(key: key);

  final User currentuser;
  final AuthService _authService;

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

bool isDarkMode = false;

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final Cart currentCart = Provider.of<CartProvider>(context).currentCart;
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: mainColor,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.currentuser.username}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(widget.currentuser.email),
                  Text(widget.currentuser.type)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text('Your Cart'),
            trailing: currentCart.products.length != 0
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: mainColor,
                    child: Text(
                      currentCart.products.length.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : Text(''),
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 150),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                            position:
                                Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                                    .animate(animation),
                            child: child);
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return CartScreen();
                      }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
              size: 30,
              color: Colors.black,
            ),
            title: Text('Your Orders',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 150),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                            position:
                                Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                                    .animate(animation),
                            child: child);
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return OrdersScreen();
                      }));
            },
          ),
          widget.currentuser.type.contains('driver')
              ? Divider(
                  thickness: 2,
                )
              : Container(),
          widget.currentuser.type.contains('driver')
              ? ListTile(
                  leading: Icon(
                    Icons.directions_car,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text('Orders to deliver',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                            pageBuilder: (context, animation, animationTime) {
                              return DeliverOrdersScreen();
                            }));
                  })
              : Container(),
          Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Icon(
                  Icons.nightlight_round,
                  color: Colors.black,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: 75,
                    child: Switch(
                      activeColor: Colors.black,
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = !isDarkMode;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
            title:
                Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 150),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                            position:
                                Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                                    .animate(animation),
                            child: child);
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return SettingsScreen();
                      }));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
              color: Colors.red,
            ),
            title: Text(
              'Sign out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              final cprovider =
                  Provider.of<CartProvider>(context, listen: false);
              cprovider.emptyCart();
              await widget._authService.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
