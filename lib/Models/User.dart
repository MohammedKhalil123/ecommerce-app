import 'package:flutter/cupertino.dart';

class User {
  // to model the current user with imporant information
  String id;
  String username;
  String email;
  String type;

  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.type,
  });
}
