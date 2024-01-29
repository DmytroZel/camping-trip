import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/use_cases/invite_user_use_case/invite_user_use_case.dart';
import 'package:camp_trip/data/use_cases/trip_use_case/trip_use_case.dart';
import 'package:camp_trip/data/use_cases/user_use_case/user_use_case.dart';
import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class TripSettingsVM extends BaseVM {
  final TripUseCase _tripUseCase;
  final InviteUserUseCase _inviteUserUseCase;
  final UserUseCase _userUseCase;
  String tripId;
  TripModel? trip;
  bool _isAdmin = false;
  bool _canEdit = false;

  bool get isAdmin => _isAdmin;

  bool get canEdit => _canEdit;
  UserModel? _user;
  List<MemberModel> members = [];
  int period = 1;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().copyWith(day: DateTime.now().day + 1);
  StreamController<String> onLoadName = StreamController<String>.broadcast();
  StreamController<String> onLoadTotalMembers =
      StreamController<String>.broadcast();

  TripSettingsVM(this._tripUseCase, this._inviteUserUseCase, this._userUseCase,
      {@factoryParam required this.tripId}) {
    _subForTripModelChanges();
    _getUser();
    _getMembers();
  }

  _getMembers() {
    _tripUseCase.getMember(tripId).listen((event) {
      members = event;
      notifyListeners();
    }).toBag(bag);
  }

  _getUser() {
    _userUseCase.getMyProfileStream().listen((event) {
      _onUserChanged(event);
    }).toBag(bag);
  }

  _onUserChanged(UserModel event) {
    _user = event;
    _isAdmin = _user?.id == trip?.organizer;
    _canEdit = _isAdmin;
    notifyListeners();
  }

  _subForTripModelChanges() {
    _tripUseCase.getTrip(tripId).listen((event) {
      _onTripChanged(event);
    }).toBag(bag);
  }

  _onTripChanged(TripModel event) {
    onLoadName.add(event.name);
    onLoadTotalMembers.add(event.totalMembers.toString());
    trip = event;
    startDate = trip?.startDate ?? DateTime.now();
    endDate =
        trip?.endDate ?? DateTime.now().copyWith(day: DateTime.now().day + 1);
    onChangedPeriod();
    notifyListeners();
  }

  onUserSelected(UserModel userModel) async {
    await _inviteUserUseCase.addOrUpdate(
        userId: userModel.id,
        userName: userModel.userName,
        tripName: trip?.name ?? '',
        tripId: trip?.id ?? '',
        isRequest: false);
    notifyListeners();
  }

  addLocalUser(String name) async {
    showProgress();
    final MemberModel member = MemberModel(
        userId: Uuid().v4(), userName: name, role: MemberModel.member);

    trip?.members.add(member.userId);
    await _tripUseCase.addOrUpdateMember(member, tripId);
    await _tripUseCase.addOrUpdate(trip!);
    hideProgress();
    notifyListeners();
  }

  bool isMyself(String member) {
    return member == _user?.id;
  }

  onRemoveMember(String member) async {
    await _tripUseCase.deleteMember(member, trip!);
    notifyListeners();
  }

  onRemoveTrip() async {
    await _tripUseCase.deleteTrip(tripId);
    notifyListeners();
  }

  onChangedName(String value) {
    trip?.name = value;
    notifyListeners();
  }

  onChangedPeriod() {
    period = endDate.difference(startDate).inDays;
  }

  onCahangeTotalMembers(String value) {
    trip?.totalMembers = int.parse(value);
    notifyListeners();
  }

  onChangedStartDate(DateTime value) {
    startDate = value;
    trip?.startDate = value;
    onChangedPeriod();
    notifyListeners();
  }

  onChangedEndDate(DateTime value) {
    endDate = value;
    trip?.endDate = value;
    onChangedPeriod();
    notifyListeners();
  }

  saveChanges() async {
    showProgress();
    await _tripUseCase.addOrUpdate(trip!);
    hideProgress();
    goBack();
  }
}
