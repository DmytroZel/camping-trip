import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/usecases/auth_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainVm extends BaseVM {
  final AuthUseCase _authUseCase;

  MainVm(this._authUseCase){
   _subForAuthChanges();
  }

  StreamController<void> goToInitial = StreamController<void>();

  onLogoutTap() async {
    await _authUseCase.singOut();
  }

  _subForAuthChanges() {
    _authUseCase.isLogIn().listen((event) {
      if (!event) {
        goToInitial.sink.add(null);
      }
    }).toBag(bag);
  }
}
