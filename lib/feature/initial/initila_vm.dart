import 'dart:async';
import 'package:injectable/injectable.dart';

import '../../common/base/base_vm.dart';
import '../../data/use_cases/auth_use_case/auth_use_case.dart';

@injectable
class InitialVm extends BaseVM {
  final AuthUseCase _authUseCase;

  InitialVm(this._authUseCase) {
    bagSub.add(isLogIn);
  }

  StreamController<bool> isLogIn = StreamController<bool>();
  double width = 0;
  double height = 0;

  startTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    _subForAuthChanges();
  }

  onStartAnimation() {
    width = 200;
    height = 200;
    notifyListeners();
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
