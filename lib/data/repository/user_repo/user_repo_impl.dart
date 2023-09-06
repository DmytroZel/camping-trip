import 'package:camp_trip/data/api/user_api/firebase_user_api.dart';
import 'package:camp_trip/data/repository/user_repo/user_repo.dart';
import 'package:camp_trip/domain/model/repository/user_model_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_user_model.dart';
import '../../shared_preferences/shared_preferences_module.dart';

@Injectable(as: UserRepo)
class UserRepoImpl extends UserRepo {
  final FirebaseUserAPi firebaseUserAPi;
  final SharedPreferencesModule sharedPreferencesModule;

  UserRepoImpl(this.firebaseUserAPi, this.sharedPreferencesModule);
  @override
  Future<void> addOrUpdate(UserModelRepo userModel) {
    return firebaseUserAPi.addOrUpdate(FirebaseUserModel.fromRepo(userModel));
  }

  @override
  Future<void> deleteUser(String userId) {
    return firebaseUserAPi.deleteUser(userId);
  }

  @override
  Stream<UserModelRepo> getMyProfileStream() async* {
    final userId = await sharedPreferencesModule.getCurrentProfileId();
    yield* firebaseUserAPi
        .getMyProfileStream(userId ?? '')
        .map((event) => UserModelRepo.fromFirebase(event));
  }

  @override
  Future<UserModelRepo> getUser(String userId) {
    return firebaseUserAPi
        .getUser(userId)
        .then((value) => UserModelRepo.fromFirebase(value));
  }

  @override
  Future<String?> getMyProfileId() async {
    return sharedPreferencesModule.getCurrentProfileId();
  }

  @override
  Stream<List<UserModelRepo>> getUsers() {
    return firebaseUserAPi.getUsers().map(
        (event) => event.map((e) => UserModelRepo.fromFirebase(e)).toList());
  }
}
