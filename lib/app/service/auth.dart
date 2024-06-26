import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final credential = GoogleAuthProvider.credential(idToken: '');



  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<void> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword( email: email, password: password);
    await _firebaseAuth.currentUser?.updateDisplayName(username);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}