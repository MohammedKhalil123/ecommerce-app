import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String _email, String _password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return authResult;
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> signIn(String _email, String _password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: _email, password: _password);
    return authResult;
  }
}
