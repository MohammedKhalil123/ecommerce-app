import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String route = 'LoginScreeen';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
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
              SizedBox(
                height: 30,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.amber[200],
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.amber[200],
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
