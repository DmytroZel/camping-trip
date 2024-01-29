import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:injectable/injectable.dart';

import '../../data/use_cases/auth_use_case/auth_use_case.dart';
import '../../data/use_cases/trip_use_case/trip_use_case.dart';
import '../../data/use_cases/user_use_case/user_use_case.dart';
import '../../domain/model/model/user_model.dart';

@injectable
class MainVm extends BaseVM {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;
  final TripUseCase _tripUseCase;

  MainVm(this._authUseCase, this._userUseCase, this._tripUseCase) {
    _subForAuthChanges();
    _subForUserModel();
    _subForTrips();
  }

  UserModel? userModel;
  List<TripModel> trips = [];
  int selectedPageIndex = 0;

  StreamController<void> goToInitial = StreamController<void>();

  onLogoutTap() async {
    await _authUseCase.singOut();
  }

  onSelectedPage(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  _subForUserModel() {
    _userUseCase.getMyProfileStream().listen((event) {
      _onChangeUserModel(event);
    }).toBag(bag);
  }

  _subForTrips() {
    _tripUseCase.getTrips().listen((event) {
      _onChangeTrips(event);
    }).toBag(bag);
  }

  _onChangeTrips(List<TripModel> trips) {
    this.trips = trips;
    notifyListeners();
  }

  _onChangeUserModel(UserModel user) {
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

  String getUserName() {
    return userModel?.userName ?? '';
  }

  bool isTripOwner(String tripId) {
    return userModel?.id == tripId;
  }
}
