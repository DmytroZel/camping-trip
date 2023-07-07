import 'package:camp_trip/data/usecases/auth_use_case.dart';
import 'package:injectable/injectable.dart';

import '../repository/auth_repository/auth_repo.dart';

@Injectable(as: AuthUseCase)
class AuthUseCaseImpl extends AuthUseCase {
  final AuthRepo authRepo;

  AuthUseCaseImpl(this.authRepo);

  @override
  Stream<String?> getCurrentProfileIdStream() {
    return authRepo.getCurrentProfileIdStream();
  }

  @override
  String getId() {
    return authRepo.getId();
  }

  @override
  Stream<bool> isLogIn() {
    return authRepo.isLogIn();
  }

  @override
  bool isLogInBool() {
     return authRepo.isLogInBool();
  }

  @override
  Future<String?> registerWithEmailAndPassword(String email, String password) {
    return authRepo.registerWithEmailAndPassword(email, password);

  }

  @override
  Future<String?> signInWithEmailAndPassword(String email, String password) {
    return authRepo.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> singOut() {
    return authRepo.singOut();
  }

  @override
  Future<String?> getCurrentProfileId() {
    return authRepo.getCurrentProfileId();
  }
}
