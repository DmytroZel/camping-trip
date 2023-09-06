import 'package:camp_trip/data/api/firebase_trip_api/firebase_trip_api.dart';
import 'package:camp_trip/data/api/invite_api/invite_api.dart';
import 'package:camp_trip/data/api/user_api/firebase_user_api.dart';
import 'package:camp_trip/domain/model/api_model/firebase_invite_user_model.dart';
import 'package:camp_trip/domain/model/api_model/firebase_trip_model.dart';
import 'package:camp_trip/domain/model/repository/invite_user_model_repo.dart';
import 'package:injectable/injectable.dart';

import 'invite_repo.dart';

@Injectable(as: InviteRepo)
class InviteRepoImpl implements InviteRepo {
  final InviteApi inviteApi;
  final FirebaseTripApi firebaseTripApi;
  final FirebaseUserAPi firebaseUserAPi;

  InviteRepoImpl(this.firebaseTripApi, this.firebaseUserAPi, this.inviteApi);

  @override
  Stream<List<InviteUserModelRepo>> getInvites(String userId) {
    return inviteApi.getInvites(userId).map((event) => event
        .map<InviteUserModelRepo>(
            (invite) => InviteUserModelRepo.fromApi(invite))
        .toList());
  }

  @override
  Future<void> addOrUpdate(InviteUserModelRepo inviteUserModel) async {
    if (inviteUserModel.isAccepted) {
      FirebaseTripModel trip =
          await firebaseTripApi.getTrip(inviteUserModel.tripId).first;
      trip.members.add(inviteUserModel.userId);
      final user = await firebaseUserAPi.getUser(inviteUserModel.userId);
      await firebaseTripApi.addOrUpdateMember(
          FirebaseMemberModel.userModel(user), trip.id);
      await firebaseTripApi.addOrUpdate(trip);
      return await inviteApi.deleteInvite(inviteUserModel.id);
    }
    return inviteApi
        .addOrUpdate(FirebaseInviteUserModel.fromRepo(inviteUserModel));
  }

  @override
  Future<void> deleteInvite(String inviteId) {
    return inviteApi.deleteInvite(inviteId);
  }

  @override
  Future<InviteUserModelRepo?> getInvite(String userId, String tripId) {
    return inviteApi.getInvite(userId, tripId).then(
        (value) => value == null ? null : InviteUserModelRepo.fromApi(value));
  }
}
