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
    onChangedPeriod();
    getMe();
  }

  String? name;
  String? myId;
  int period = 1;
  String? organizer;
  List<String>? members;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().copyWith(day: DateTime.now().day + 1);

  Future<void> createTrip() async {
    showProgress();
    final trip = TripModel(
        id: const Uuid().v4(),
        name: name!,
        period: period.toString(),
        organizer: myId!,
        members: [myId!],
        startDate: startDate,
        endDate: endDate);
    await tripUseCase.addOrUpdate(trip);
    hideProgress();
    goBack();
  }

  Future<void> getMe() async {
    myId = await userUseCase.getMyProfileId();
    notifyListeners();
  }

  onChangedName(String value) {
    name = value;
  }

  onChangedPeriod() {
    period = endDate.difference(startDate).inDays;
  }

  onChangedStartDate(DateTime value) {
    startDate = value;
    onChangedPeriod();
    notifyListeners();
  }

  onChangedEndDate(DateTime value) {
    endDate = value;
    onChangedPeriod();
    notifyListeners();
  }
}
