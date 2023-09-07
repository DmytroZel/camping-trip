import 'package:camp_trip/data/repository/user_repo/user_repo.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/model/user_model.dart';
import '../../../domain/model/repository/user_model_repo.dart';

@Injectable(as: UserUseCase)
class UserUseCaseImpl extends UserUseCase {
  final UserRepo userRepo;

  UserUseCaseImpl(this.userRepo);
  @override
  Future<void> addOrUpdate(UserModel userModel) async {
    UserModel user = userModel;
    if (userModel.imageToUpload != null) {
      final image = await userRepo.uploadImageToUser(userModel.id, userModel.imageToUpload!);
      user = userModel.copyWith(image: image);
    }
    return userRepo.addOrUpdate(UserModelRepo.fromModel(user));
  }

  @override
  Future<void> deleteUser(String userId) {
    return userRepo.deleteUser(userId);
  }

  @override
  Stream<UserModel> getMyProfileStream() {
    return userRepo
        .getMyProfileStream()
        .map((event) => UserModel.fromRepo(event));
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final user = await userRepo.getUser(userId);
    return UserModel.fromRepo(user);
  }

  @override
  Future<String?> getMyProfileId() {
    return userRepo.getMyProfileId();
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return userRepo
        .getUsers()
        .map((event) => event.map((e) => UserModel.fromRepo(e)).toList());
  }
}
