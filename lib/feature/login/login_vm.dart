import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../common/base/base_vm.dart';
import '../../data/use_cases/auth_use_case/auth_use_case.dart';

@injectable
class LoginVm extends BaseVM {
  final AuthUseCase _authUseCase;
  String? _email;
  String? _password;
  String? userName;
  StreamController<void> goToMain = StreamController<void>();
  StreamController<void> showRegisterMassage = StreamController<void>();
  StreamController<String> showError = StreamController<String>();

  LoginVm(this._authUseCase);

  _singInWithEmailAndPassword() async {
    try {
      if (_email != null &&
          _password != null &&
          _email!.isNotEmpty &&
          _password!.isNotEmpty) {
        try {
          await _authUseCase.signInWithEmailAndPassword(_email!, _password!);
          goToMain.sink.add(null);
        } catch (e) {
          showError.sink.add(e.toString());
        }
      } else {
        if (_email != null &&
            _password != null &&
            _email!.isNotEmpty &&
            _password!.isNotEmpty) {
          showRegisterMassage.sink.add(null);
        } else {
          showError.sink.add("Please enter email and password");
        }
      }
    } catch (e) {
      showError.sink.add("Please enter email and password");
    }
  }

  onLoginTap() async {
    showProgress();
    await _singInWithEmailAndPassword();
    hideProgress();
  }

  onRegisterTap() async {
    showProgress();
    if (_email != null &&
        _password != null &&
        _email!.isNotEmpty &&
        _password!.isNotEmpty) {
      _authUseCase.registerWithEmailAndPassword(_email!, _password!, userName!);
      goToMain.sink.add(null);
    } else {
      showError.sink.add("Please enter email and password");
    }
    hideProgress();
  }

  onEmailChanged(String email) {
    _email = email;
  }

  onPasswordChanged(String password) {
    _password = password;
  }

  onUserNameChanged(String userName) {
    this.userName = userName;
  }
}
