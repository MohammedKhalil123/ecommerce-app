import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUp(String _email, String _password) {}

  Future signOut() async {
    await _auth.signOut();
  }

  signIn(String _email, String _password) {}
}
