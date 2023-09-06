import '../../../domain/model/model/invite_user_model.dart';
import '../../../domain/model/model/trip_model.dart';

abstract class InviteUserUseCase {
  Stream<List<InviteUserModel>> getInvites(String userId);
  Future<void> addOrUpdate(
      {required String userId,
      required String userName,
      required String tripName,
      required String tripId,
      required bool isRequest});
  Future<void> accept(InviteUserModel inviteUserModel);
  Future<void> deleteInvite(String inviteId);
  Future<void> updateRole(MemberModel memberModel, int role, String tripId);
}
