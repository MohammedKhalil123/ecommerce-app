import 'package:ecommerce/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/Widgets/CustomFormField.dart';
import 'Signup.dart';

class LoginScreen extends StatelessWidget {
  static String route = 'LoginScreeen';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  child: FlatButton(
                      height: MediaQuery.of(context).size.height * 0.07,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Log in'),
                      onPressed: () {
                        _formKey.currentState.validate();
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.route);
                      }),
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
