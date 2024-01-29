import 'package:injectable/injectable.dart';

import '../../../../common/base/base_vm.dart';
import '../../../../data/use_cases/trip_use_case/trip_use_case.dart';

@injectable
class MembersVM extends BaseVM {
  final TripUseCase _tripUseCase;

  MembersVM(this._tripUseCase);
}
