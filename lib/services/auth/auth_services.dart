import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  //register
  Future<UserCredential?> signUpFirestore(String email, String password){
    try {
      return auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }catch(e){
      throw Exception(handleAuthError(e.toString()));
    }
  }

  //login
  Future<UserCredential?> login(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
        email: email, password: password,
      );
    } catch (e) {
      throw Exception(handleAuthError(e.toString()));
    }
  }

  //logout
  Future<void> logout() async{
    await auth.signOut();
  }

  String handleAuthError(String error) {
    if (error.contains('user-not-found'))
      return 'No user found for that email.';
    if (error.contains('wrong-password'))
      return 'Incorrect password.';
    if (error.contains('email-already-in-use'))
      return 'Email is already registered.';

    return 'Authentication failed. Please try again.';
  }

}