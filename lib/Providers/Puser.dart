import 'package:ecommerce/Models/User.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  User user;

  void changeuser(User currentuser) {
    user = User(
        id: currentuser.id,
        username: currentuser.username,
        email: currentuser.email,
        type: currentuser.type);
    notifyListeners();
  }
}
