import '../../../domain/model/repository/user_model_repo.dart';

abstract class UserUseCase {
  Future<void> addOrUpdate(UserModelRepo userModel);
  Future<void> deleteUser(String userId);
  Future<UserModelRepo> getUser(String userId);
  Stream<UserModelRepo> getMyProfileStream();
  Future<String?> getMyProfileId();
}
