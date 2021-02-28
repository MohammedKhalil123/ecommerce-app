import 'package:flutter/cupertino.dart';

class User {
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
