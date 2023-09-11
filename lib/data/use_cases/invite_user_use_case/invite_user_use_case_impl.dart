import 'package:camp_trip/data/use_cases/invite_user_use_case/invite_user_use_case.dart';
import 'package:camp_trip/domain/model/model/invite_user_model.dart';
import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:camp_trip/domain/model/repository/invite_user_model_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../repository/invite_repo/invite_repo.dart';
import '../../repository/trip_repo/trip_repo.dart';

@Injectable(as: InviteUserUseCase)
class InviteUserUseCaseImpl extends InviteUserUseCase {
  final InviteRepo _inviteRepo;
  final TripRepo _tripRepo;

  InviteUserUseCaseImpl(this._inviteRepo, this._tripRepo);

  @override
  Future<void> deleteInvite(String inviteId) {
    return _inviteRepo.deleteInvite(inviteId);
  }

  @override
  Stream<List<InviteUserModel>> getInvites(String userId) {
    return _inviteRepo
        .getInvites(userId)
        .map((event) => event.map((e) => InviteUserModel.fromRepo(e)).toList());
  }

  @override
  Future<void> addOrUpdate(
      {required String userId,
      required String userName,
      required String tripName,
      required String tripId,
      required bool isRequest}) async {
    final inviteUserModelRepo = await _inviteRepo
        .getInvite(userId, tripId);
    final inviteUserModel = inviteUserModelRepo != null
        ? InviteUserModel.fromRepo(inviteUserModelRepo)
        : null;
    if (inviteUserModel != null) {
      return _inviteRepo.addOrUpdate(InviteUserModelRepo.fromModel(inviteUserModel.copyWith(
          isAccepted: false,
          isRequested: isRequest,
          createdAt: DateTime.now())));
    }
    final model = InviteUserModel(
        userId: userId,
        tripId: tripId,
        isAccepted: false,
        isRequested: isRequest,
        id: const Uuid().v4(),
        createdAt: DateTime.now(),
        userName: userName,
        tripName: tripName);
    return _inviteRepo.addOrUpdate(InviteUserModelRepo.fromModel(model));
  }

  @override
  Future<void> accept(InviteUserModel inviteUserModel) {
    InviteUserModel model = inviteUserModel.copyWith(isAccepted: true);
    return _inviteRepo.addOrUpdate(InviteUserModelRepo.fromModel(model));
  }

  @override
  Future<void> updateRole(MemberModel memberModel, int role, String tripId) {
    MemberModel model = memberModel.copyWith(role: role);
    return _tripRepo.addOrUpdateMember(model, tripId);
  }
}
