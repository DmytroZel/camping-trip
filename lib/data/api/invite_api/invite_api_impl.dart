import 'package:camp_trip/domain/model/api_model/firebase_invite_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'invite_api.dart';

@Injectable(as: InviteApi)
class InviteApiImpl extends InviteApi {
  final FirebaseFirestore firebaseFirestore;
  late final invites = firebaseFirestore.collection('invites');

  InviteApiImpl(this.firebaseFirestore);

  @override
  Future<void> addOrUpdate(FirebaseInviteUserModel inviteUserModel) {
    return invites.doc(inviteUserModel.id).set(inviteUserModel.toJson());
  }

  @override
  Future<void> deleteInvite(String inviteId) {
    return invites.doc(inviteId).delete();
  }

  @override
  Stream<List<FirebaseInviteUserModel>> getInvites(String userId) {
    return invites.where('userId', isEqualTo: userId).snapshots().map((event) =>
        event.docs
            .map<FirebaseInviteUserModel>(
                (invite) => FirebaseInviteUserModel.fromJson(invite.data()))
            .toList());
  }

  @override
  Future<FirebaseInviteUserModel?> getInvite(String userId, String tripId) async {
   try {
      final invite = await invites
          .where('userId', isEqualTo: userId)
          .where('tripId', isEqualTo: tripId)
          .get();
      return FirebaseInviteUserModel.fromJson(invite.docs.first.data());
    } catch (e) {
      return null;
    }
  }
}
