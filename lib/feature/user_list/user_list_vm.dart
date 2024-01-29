import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/model/user_model.dart';

@injectable
class UserListVm extends BaseVM {
  final UserUseCase _userUseCase;

  UserListVm(this._userUseCase) {
    _subForUsers();
  }

  final List<UserModel> users = [];
  String? _localUserName;

  _subForUsers() {
    _userUseCase.getUsers().listen((event) {
      _onUsersChanged(event);
    }).toBag(bag);
  }

  onNameChanged(String value) {
    _localUserName = value;
  }

  String get localUserName => _localUserName ?? '';

  _onUsersChanged(List<UserModel> event) {
    users.clear();
    users.addAll(event);
    notifyListeners();
  }

  UserModel? selectedUser;
}
