abstract class AuthUseCase {
  Stream<bool> isLogIn();

  bool isLogInBool();

  Future<void> singOut();

  String getId();

  Future<String?> registerWithEmailAndPassword(
      String email, String password, String userName);

  Future<String?> signInWithEmailAndPassword(String email, String password);

  Stream<String?> getCurrentProfileIdStream();

  Future<String?> getCurrentProfileId();
}
