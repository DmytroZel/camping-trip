import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/data/use_cases/trip_use_case/trip_use_case.dart';
import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../data/use_cases/user_use_case/user_use_case.dart';

@injectable
class CreateTripVm extends BaseVM {
  final TripUseCase tripUseCase;
  final UserUseCase userUseCase;

  CreateTripVm(this.tripUseCase, this.userUseCase) {
    getMe();
  }

  String? name;
  String? myId;
  int period = 1;
  String? organizer;
  List<String>? members;

  Future<void> createTrip() async {
    final trip = TripModel(
        id: Uuid().v4(),
        name: name!,
        period: period.toString(),
        organizer: myId!,
        members: []);
    await tripUseCase.addOrUpdate(trip);
  }

  Future<void> getMe() async {
    myId = await userUseCase.getMyProfileId();
    notifyListeners();
  }

  onChangedName(String value) {
    name = value;
  }

  onChangedPeriod(bool value) {
    if (period == 1 && value == false) {
      return;
    }
    period = value ? period += 1 : period -= 1;
    notifyListeners();
  }
}
