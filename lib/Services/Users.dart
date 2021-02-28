import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Models/User.dart';
import 'package:ecommerce/constants.dart';

class UserServices {
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  void addUser(User newuser) async {
    await db.doc(newuser.id).set({
      u_username: newuser.username,
      u_email: newuser.email,
      u_id: newuser.id,
      u_type: newuser.type,
    });
  }

  Future<User> getUser(String id) async {
    DocumentSnapshot usersnap = await db.doc(id).get();

    final userdata = usersnap.data();
    final userkeys = userdata.keys.toList();
    User _user = User(
        email: userdata[userkeys[0]],
        id: userdata[userkeys[1]],
        type: userdata[userkeys[2]],
        username: userdata[userkeys[3]]);

    return _user;
  }
}
