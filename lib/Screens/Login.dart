import 'package:ecommerce/Models/Cart.dart';
import 'package:ecommerce/Providers/Pcart.dart';
import 'package:ecommerce/Screens/Home.dart';
import 'package:ecommerce/Services/Auth.dart';
import 'package:ecommerce/Services/Carts.dart';
import 'package:ecommerce/Services/Users.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/Widgets/CustomFormField.dart';
import 'package:provider/provider.dart';
import 'Signup.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Providers/Puser.dart';

class LoginScreen extends StatelessWidget {
  static String route = 'LoginScreeen';

  final AuthService authservice = AuthService();
  final CartService _cartservice = CartService();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _email, _password;
    return Material(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Container(
                    height: 150,
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child:
                              Image(image: AssetImage('images/shopping.png'))),
                      Positioned(
                          bottom: 0,
                          child: Text(
                            'E-Commerce App',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                    ]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                CustomFormField(
                  saved: (String val) {
                    _email = val;
                  },
                  hint: 'Email Address',
                  icon: Icons.mail,
                  isPassword: false,
                  validation: (String val) {
                    if (val.isEmpty)
                      return 'You have not entered email address';
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                CustomFormField(
                  saved: (String val) {
                    _password = val;
                  },
                  hint: 'Password',
                  icon: Icons.vpn_key,
                  isPassword: true,
                  validation: (String val) {
                    if (val.isEmpty)
                      return 'You have not entered your password';
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Builder(
                    builder: (context) => FlatButton(
                        height: MediaQuery.of(context).size.height * 0.07,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Text('Log in'),
                        onPressed: () async {
                          //validating and saving the form
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              final authResult =
                                  await authservice.signIn(_email, _password);
                              UserServices uService = UserServices();

                              //gettting the user from the database
                              User currentuser =
                                  await uService.getUser(authResult.user.uid);

                              final uprovider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);

                              final cprovider = Provider.of<CartProvider>(
                                  context,
                                  listen: false);

                              // adding user model to provider
                              uprovider.changeuser(currentuser);

                              // get cart from database
                              Cart cartFromDatabase =
                                  await _cartservice.getCart(currentuser);
                              //adding it to provider
                              cprovider.getCart(cartFromDatabase);

                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.route);
                            } catch (e) {
                              //shows sign in errors
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(e.message),
                              ));
                            }
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not registered yet? ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, SignupScreen.route);
                      },
                      child: Text(
                        'Sign up here',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
