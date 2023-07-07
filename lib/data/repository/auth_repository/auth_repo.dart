abstract class AuthRepo {
  Stream<bool> isLogIn();

  bool isLogInBool();

  Future<void> singOut();

  String getId();

  Future<String?> getCurrentProfileId();

  Future<void> setCurrentProfileId(String? id);

  Future<String?> registerWithEmailAndPassword(String email, String password);

  Future<String?> signInWithEmailAndPassword(String email, String password);

  Stream<String?> getCurrentProfileIdStream();
}