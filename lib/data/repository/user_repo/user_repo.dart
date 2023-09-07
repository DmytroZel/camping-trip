import 'package:camp_trip/domain/model/repository/user_model_repo.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepo {
  Future<void> addOrUpdate(UserModelRepo userModel);
  Future<void> deleteUser(String userId);
  Future<UserModelRepo> getUser(String userId);
  Stream<List<UserModelRepo>> getUsers();
  Stream<UserModelRepo> getMyProfileStream();
  Future<String?> getMyProfileId();
  Future<String> uploadImageToUser(String user, XFile image);
}
