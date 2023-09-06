import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountVM extends BaseVM {
  final UserUseCase userUseCase;
  UserModel? user;
  String? newImage;

  AccountVM(this.userUseCase);

  loadData() async {
    userUseCase.getMyProfileStream().listen((event) {
      user = event;
      notifyListeners();
    }).toBag(bag);
  }

  String getName() {
    return user?.userName ?? "";
  }

  String getEmail() {
    return user?.email ?? "";
  }

  String? getImage() {
    return newImage ?? user?.image;
  }

  String getGenderString() {
    return user?.getGender() ?? "";
  }

  bool getGender() {
    return user?.gender ?? true;
  }

  onNameChanged(String value) {
    user = user?.copyWith(userName: value);
    notifyListeners();
  }

  onGenderChanged(bool gender) {
    user = user?.copyWith(gender: gender);
    notifyListeners();
  }

  onImageChanged(String? image) {
    newImage = image;
    notifyListeners();
  }

  onSave() async {
    showProgress();
    await userUseCase.addOrUpdate(user!);
    hideProgress();
    goBack();
  }
}
