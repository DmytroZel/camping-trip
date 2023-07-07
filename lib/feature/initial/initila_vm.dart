import 'dart:async';

import 'package:camp_trip/data/usecases/auth_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../common/base/base_vm.dart';

@injectable
class InitialVm extends BaseVM{
  final AuthUseCase _authUseCase;

  InitialVm(this._authUseCase) {
    bagSub.add(isLogIn);
  }


  StreamController<bool> isLogIn = StreamController<bool>();

  startTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    _subForAuthChanges();
  }

  _subForAuthChanges() async {
    if (_authUseCase.isLogInBool()) {
      final currentProfileId = await _authUseCase.getCurrentProfileId();
      if (currentProfileId == null) {
        await _authUseCase.singOut();
        isLogIn.sink.add(false);
        return;
      }
    }
    isLogIn.sink.add(_authUseCase.isLogInBool());
  }
}