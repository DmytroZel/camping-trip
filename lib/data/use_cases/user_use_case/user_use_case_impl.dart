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
  Future<void> addOrUpdate(UserModel userModel) {
    return userRepo.addOrUpdate(UserModelRepo.fromModel(userModel));
  }

  @override
  Future<void> deleteUser(String userId) {
    return userRepo.deleteUser(userId);
  }

  @override
  Stream<UserModel> getMyProfileStream() {
    return userRepo.getMyProfileStream().map((event) => UserModel.fromRepo(event));
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
}
