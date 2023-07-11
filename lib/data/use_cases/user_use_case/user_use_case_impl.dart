import 'package:camp_trip/data/repository/user_repo/user_repo.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:camp_trip/domain/model/repository/user_model_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: UserUseCase)
class UserUseCaseImpl extends UserUseCase{
  final UserRepo userRepo;

  UserUseCaseImpl(this.userRepo);
  @override
  Future<void> addOrUpdate(UserModelRepo userModel) {
    return userRepo.addOrUpdate(userModel);
  }

  @override
  Future<void> deleteUser(String userId) {
    return userRepo.deleteUser(userId);
  }

  @override
  Stream<UserModelRepo> getMyProfileStream() {
    return userRepo.getMyProfileStream();
  }

  @override
  Future<UserModelRepo> getUser(String userId) {
    return userRepo.getUser(userId);
  }

}