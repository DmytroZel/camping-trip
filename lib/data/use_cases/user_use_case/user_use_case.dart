import '../../../domain/model/model/user_model.dart';

abstract class UserUseCase {
  Future<void> addOrUpdate(UserModel userModel);
  Future<void> deleteUser(String userId);
  Future<UserModel> getUser(String userId);
  Stream<List<UserModel>> getUsers();
  Stream<UserModel> getMyProfileStream();
  Future<String?> getMyProfileId();
}
