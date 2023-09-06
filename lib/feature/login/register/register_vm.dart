import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterVM extends BaseVM {
  final UserUseCase _userUseCase;

  RegisterVM(this._userUseCase);
}
