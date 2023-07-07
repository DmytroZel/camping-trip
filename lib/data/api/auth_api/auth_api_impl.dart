import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'auth_api.dart';

@Injectable(as: AuthApi)
class FirebaseAuthModuleImpl implements AuthApi {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthModuleImpl(this.firebaseAuth);

  @override
  String getId() {
    return firebaseAuth.currentUser?.uid ?? '';
  }

  @override
  Stream<bool> isLogIn() {
    return firebaseAuth.authStateChanges().map((event) => event != null);
  }

  @override
  bool isLogInBool() {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> singOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<String?> registerWithEmailAndPassword(String email, String password) async {
    final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user?.uid;
  }

  @override
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return credential.user?.uid;
  }

}
