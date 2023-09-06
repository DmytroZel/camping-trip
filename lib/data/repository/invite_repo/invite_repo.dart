import 'package:camp_trip/domain/model/repository/invite_user_model_repo.dart';

abstract class InviteRepo {
  Stream<List<InviteUserModelRepo>> getInvites(String userId);
  Future<void> addOrUpdate(InviteUserModelRepo inviteUserModel);
  Future<void> deleteInvite(String inviteId);
  Future<InviteUserModelRepo?> getInvite(String userId, String tripId);
}
