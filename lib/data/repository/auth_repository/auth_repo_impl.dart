import 'package:camp_trip/domain/model/api_model/firebase_user_model.dart';
import 'package:injectable/injectable.dart';

import '../../api/auth_api/auth_api.dart';
import '../../api/user_api/firebase_user_api.dart';
import '../../shared_preferences/shared_preferences_module.dart';
import 'auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthApi firebaseAuthModule;
  final SharedPreferencesModule sharedPreferencesModule;
  final FirebaseUserAPi firebaseUserAPi;

  AuthRepoImpl(this.firebaseUserAPi,
      {required this.firebaseAuthModule,
      required this.sharedPreferencesModule});

  @override
  Stream<bool> isLogIn() {
    return firebaseAuthModule.isLogIn();
  }

  @override
  Future<void> singOut() {
    sharedPreferencesModule.setCurrentProfileId(null);
    return firebaseAuthModule.singOut();
  }

  @override
  bool isLogInBool() {
    return firebaseAuthModule.isLogInBool();
  }

  @override
  String getId() {
    return firebaseAuthModule.getId();
  }

  @override
  Future<String?> getCurrentProfileId() {
    return sharedPreferencesModule.getCurrentProfileId();
  }

  @override
  Future<void> setCurrentProfileId(String? id) {
    return sharedPreferencesModule.setCurrentProfileId(id);
  }

  @override
  Stream<String?> getCurrentProfileIdStream() {
    return sharedPreferencesModule.getCurrentProfileIdStream();
  }

  @override
  Future<String?> registerWithEmailAndPassword(
      String email, String password, String userName, bool gender) async {
    final uid =
        await firebaseAuthModule.registerWithEmailAndPassword(email, password);
    if (uid == null) return null;
    await setCurrentProfileId(uid);
    final user = FirebaseUserModel(
        id: uid, userName: userName, email: email, gender: gender);
    await firebaseUserAPi.addOrUpdate(user);
    return uid;
  }

  @override
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    final uid =
        await firebaseAuthModule.signInWithEmailAndPassword(email, password);
    await setCurrentProfileId(uid);
    return uid;
  }
}
