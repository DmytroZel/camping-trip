import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/domain/model/repository/user_model_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data/use_cases/auth_use_case/auth_use_case.dart';
import '../../data/use_cases/user_use_case/user_use_case.dart';


@injectable
class MainVm extends BaseVM {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;

  MainVm(this._authUseCase, this._userUseCase){
   _subForAuthChanges();
   _subForUserModel();
  }

  UserModelRepo? userModel;

  StreamController<void> goToInitial = StreamController<void>();

  onLogoutTap() async {
    await _authUseCase.singOut();
  }


  _subForUserModel(){
    _userUseCase.getMyProfileStream().listen((event) {
      _onChangeUserModel(event);
    }).toBag(bag);
  }

  _onChangeUserModel(UserModelRepo user){
    userModel = user;
    notifyListeners();
  }

  _subForAuthChanges() {
    _authUseCase.isLogIn().listen((event) {
      if (!event) {
        goToInitial.sink.add(null);
      }
    }).toBag(bag);
  }

  String getUserName(){
    return userModel?.userName ?? '';
  }
}
