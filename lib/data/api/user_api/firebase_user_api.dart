import '../../../domain/model/api_model/firebase_user_model.dart';

abstract class FirebaseUserAPi {
  Future<void> addOrUpdate(FirebaseUserModel userModel);
  Future<void> deleteUser(String userId);
  Future<FirebaseUserModel> getUser(String userId);
  Stream<FirebaseUserModel> getMyProfileStream(String userId);
}
