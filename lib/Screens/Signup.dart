import 'package:ecommerce/Providers/Puser.dart';
import 'package:ecommerce/Screens/Home.dart';
import 'package:ecommerce/Services/Carts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/Widgets/CustomFormField.dart';
import 'package:ecommerce/Services/Auth.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/Services/Users.dart';

enum UserType { customer, driver_customer }

class SignupScreen extends StatefulWidget {
  static String route = 'SignupScreen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupformKey = GlobalKey<FormState>();
  UserType _usertype = UserType.customer;
  String _email, _password, _username;
  final AuthService authservice = AuthService();
  final CartService _cartservice = CartService();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            key: _signupformKey,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Radio(
                    activeColor: Colors.black,
                    value: UserType.customer,
                    groupValue: _usertype,
                    onChanged: (UserType value) {
                      setState(() {
                        _usertype = value;
                      });
                    },
                  ),
                  Text(
                    'Customer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Radio(
                    activeColor: Colors.black,
                    value: UserType.driver_customer,
                    groupValue: _usertype,
                    onChanged: (UserType value) {
                      setState(() {
                        _usertype = value;
                      });
                    },
                  ),
                  Text(
                    'Customer + Driver',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomFormField(
                  hint: 'UserName',
                  icon: Icons.person,
                  isPassword: false,
                  saved: (String val) {
                    _username = val;
                  },
                  validation: (String value) {
                    if (value.isEmpty) {
                      return 'You have not entered your username';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomFormField(
                  hint: 'Email Address',
                  icon: Icons.mail,
                  isPassword: false,
                  saved: (value) {
                    print('saved');
                    _email = value;
                  },
                  validation: (String value) {
                    if (value.isEmpty) {
                      return 'You have not entered your email address';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomFormField(
                  hint: 'Password',
                  icon: Icons.vpn_key,
                  isPassword: true,
                  saved: (val) {
                    _password = val;
                  },
                  validation: (String value) {
                    if (value.isEmpty) {
                      return 'You have not entered your password';
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
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
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () async {
                          if (_signupformKey.currentState.validate()) {
                            _signupformKey.currentState.save();
                            try {
                              final authResult =
                                  await authservice.signUp(_email, _password);

                              User newuser = User(
                                  email: _email,
                                  id: authResult.user.uid,
                                  type: _usertype.toString().split('.').last,
                                  username: _username);

                              UserServices uService = UserServices();

                              uService.addUser(newuser);

                              final uprovider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);

                              uprovider.changeuser(newuser);

                              _cartservice.createCart(newuser);
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.route);
                            } catch (e) {
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
                      'Already have an account? ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.route);
                      },
                      child: Text(
                        'Login in here',
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
