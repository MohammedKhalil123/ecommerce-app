import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Signing up the user to Firebase
  Future<UserCredential> signUp(String _email, String _password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return authResult;
  }

  //Sign out
  Future signOut() async {
    await _auth.signOut();
  }

  //Sign in the user
  Future<UserCredential> signIn(String _email, String _password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: _email, password: _password);
    return authResult;
  }
}
