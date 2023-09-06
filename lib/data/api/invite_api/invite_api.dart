import 'package:camp_trip/domain/model/api_model/firebase_invite_user_model.dart';

abstract class InviteApi {
  Stream<List<FirebaseInviteUserModel>> getInvites(String userId);
  Future<void> addOrUpdate(FirebaseInviteUserModel inviteUserModel);
  Future<void> deleteInvite(String inviteId);
  Future<FirebaseInviteUserModel?> getInvite(String userId, String tripId);
}
