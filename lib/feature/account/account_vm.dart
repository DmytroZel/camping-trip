import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/use_cases/invite_user_use_case/invite_user_use_case.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/model/invite_user_model.dart';

@injectable
class AccountVM extends BaseVM {
  final UserUseCase userUseCase;
  final InviteUserUseCase inviteUserUseCase;
  UserModel? user;
  String? newImage;
  List<InviteUserModel> invites = [];

  AccountVM(this.userUseCase, this.inviteUserUseCase);

  loadData() async {
    userUseCase.getMyProfileStream().listen((event) {
      user = event;
      subForInvites();
      notifyListeners();
    }).toBag(bag);
  }

  subForInvites() {
    inviteUserUseCase.getInvites(user?.id ?? '').listen((event) {
      _inviteListChanged(event);
    }).toBag(bag);
  }

  onAccept(InviteUserModel inviteUserModel) async {
    showProgress();
    final model = inviteUserModel.copyWith(isAccepted: true);
    await inviteUserUseCase.accept(model);
    hideProgress();
  }

  _inviteListChanged(List<InviteUserModel> event) {
    invites = event;
    notifyListeners();
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
