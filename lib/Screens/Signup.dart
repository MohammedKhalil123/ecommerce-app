import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/Widgets/CustomFormField.dart';

enum UserType { customer, driver_customer }

class SignupScreen extends StatefulWidget {
  static String route = 'SignupScreen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  UserType _usertype = UserType.customer;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Form(
                  key: _formKey,
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
                Text('Customer'),
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
                Text('Customer + Driver')
              ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CustomFormField(
                hint: 'UserName',
                icon: Icons.person,
                isPassword: false,
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
                child: FlatButton(
                    height: MediaQuery.of(context).size.height * 0.07,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      _formKey.currentState.validate();
                    }),
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
    );
  }
}
