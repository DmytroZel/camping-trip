import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/use_cases/invite_user_use_case/invite_user_use_case.dart';
import 'package:camp_trip/data/use_cases/trip_use_case/trip_use_case.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:camp_trip/domain/model/model/dish_model.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class TripVM extends BaseVM {
  final TripUseCase _tripUseCase;
  final UserUseCase _userUseCase;
  final InviteUserUseCase _inviteUserUseCase;
  String id;
  bool showSettings = false;
  String? newName;
  int period = 1;
  List<UserModel> users = [];
  List<MemberModel> members = [];
  List<String> membersIds = [];
  StreamSubscription? _subForUsersSubscription;

  TripVM(this._tripUseCase, @factoryParam this.id, this._userUseCase,
      this._inviteUserUseCase) {
    _subForTripModelChanges();
    _subForDishes();
    _subForMembers();
  }

  _subForMembers() {
    _tripUseCase.getMember(id).listen((event) {
      _onMembersChanged(event);
    }).toBag(bag);
  }

  onUserSelected(UserModel userModel) {
    _inviteUserUseCase.addOrUpdate(
        userId: userModel.id,
        userName: userModel.userName,
        tripName: trip?.name ?? '',
        tripId: trip?.id ?? '',
        isRequest: false);
    notifyListeners();
  }

  _onMembersChanged(List<MemberModel> event) {
    members = event;
    notifyListeners();
  }

  TripModel? trip;
  List<DishModel> dishItems = [];
  DishModel? selectedDish;

  _subForTripModelChanges() {
    _tripUseCase.getTrip(id).listen((event) {
      _onTripModelChanged(event);
    }).toBag(bag);
  }

  onNameChanged(String value) {
    newName = value;
    notifyListeners();
  }

  onChangedPeriod(bool value) {
    if (value) {
      period = period + 1;
    } else {
      period = period - 1;
    }
    notifyListeners();
  }

  onAddMember(MemberModel value) {
    members.add(value);
    notifyListeners();
  }

  onShowSettings() {
    showSettings = !showSettings;
    notifyListeners();
  }

  List<DishModel> getDeyDishItems(int day) {
    var dishes = dishItems.where((element) => element.day == day).toList();
    dishes.sort((a, b) => a.type!.compareTo(b.type as num));
    return dishes;
  }

  onDishSelected(DishModel dishModel) {
    if (selectedDish == dishModel) {
      selectedDish = null;
      notifyListeners();
      return;
    }
    selectedDish = dishModel;
    notifyListeners();
  }

  onAddIngredientToDish(IngredientModel item, String dishId) {
    final dishIndex = dishItems.indexWhere((element) => element.id == dishId);
    if (dishIndex == -1) return;
    if (dishItems[dishIndex].ingredients == null) {
      dishItems[dishIndex] = dishItems[dishIndex].copyWith(ingredients: []);
    }
    dishItems[dishIndex].ingredients?.add(item);
    notifyListeners();
  }

  _onTripModelChanged(TripModel? event) {
    trip = event;
    period = int.tryParse(trip!.period) ?? 0;
    newName = trip!.name;
    membersIds = trip!.members;
    notifyListeners();
  }

  onChangedName(String value) {
    newName = value;
    notifyListeners();
  }

  int getTripPeriod() {
    if (trip == null) return 0;
    return int.tryParse(trip!.period) ?? 0;
  }

  String getDishPeriodTitle(int period) {
    switch (period) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Snack';
      case 3:
        return 'Dinner';
      case 4:
        return 'Dessert';
      default:
        return '';
    }
  }

  _subForDishes() {
    _tripUseCase.getDishItems(id).listen((event) {
      _onDishItemsChanged(event);
    }).toBag(bag);
  }

  _onDishItemsChanged(List<DishModel> event) {
    dishItems = event;
    notifyListeners();
  }
}
