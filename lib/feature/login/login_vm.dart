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
  bool sex = true;
  String? _confirmPassword;
  bool isRegister = false;
  bool showRegisterPage = false;
  bool showPassword = false;
  StreamController<void> goToMain = StreamController<void>();
  StreamController<bool> loginRes = StreamController<bool>();
  StreamController<void> showRegisterMassage = StreamController<void>();
  StreamController<String> showError = StreamController<String>();

  LoginVm(this._authUseCase);

  Future<bool> _singInWithEmailAndPassword() async {
    showProgress();
    bool res = false;
    try {
      if (_email != null &&
          _password != null &&
          _email!.isNotEmpty &&
          _password!.isNotEmpty) {
        try {
          await _authUseCase.signInWithEmailAndPassword(_email!, _password!);
          loginRes.add(true);
          goToMain.sink.add(null);
        } catch (e) {
          isRegister = true;
          loginRes.add(false);
          showError.sink.add(
              'Email or password is incorrect, please try again or register');
        }
      } else {
        if (_email != null &&
            _password != null &&
            _email!.isNotEmpty &&
            _password!.isNotEmpty) {
          loginRes.add(false);
          showRegisterMassage.sink.add(null);
        } else {
          loginRes.add(false);
          showError.sink.add("Please enter email and password");
        }
      }
    } catch (e) {
      loginRes.add(false);
      showError.sink.add("Please enter email and password");
    }
    notifyListeners();
    return res;
  }

  onSexChanged(bool val){
    sex = val;
    notifyListeners();
  }

  onConfirmPasswordChanged(String val){
    _confirmPassword = val;
    notifyListeners();
  }

  checkPassword(){
    if(_password != null && _confirmPassword != null && _password!.isNotEmpty && _confirmPassword!.isNotEmpty){
      if(_password == _confirmPassword){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  onRegisterTap(){
    showRegisterPage = !showRegisterPage;
    notifyListeners();
  }

  onShowPasswordTap() {
    showPassword = !showPassword;
    notifyListeners();
  }

  Future<bool> onLoginTap() async {
    showProgress();
    bool res = false;
    try {
      res = await _singInWithEmailAndPassword();
    } catch (_) {
    }
    notifyListeners();
    hideProgress();
    return res;
  }

  onRegister() async {
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
