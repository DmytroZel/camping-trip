import '../api_model/firebase_invite_user_model.dart';
import '../model/invite_user_model.dart';

class InviteUserModelRepo {
  final String id;
  final String tripId;
  final String userId;
  final String userName;
  final String tripName;
  final bool isAccepted;
  final bool isRequested;
  final DateTime? createdAt;

  InviteUserModelRepo({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.userName,
    required this.tripName,
    required this.isAccepted,
    required this.isRequested,
    this.createdAt,
  });

  InviteUserModelRepo.fromApi(FirebaseInviteUserModel r)
      : id = r.id,
        tripId = r.tripId,
        userId = r.userId,
        userName = r.userName,
        tripName = r.tripName,
        isAccepted = r.isAccepted,
        isRequested = r.isRequested,
        createdAt = r.createdAt;

  InviteUserModelRepo.fromModel(InviteUserModel r)
      : id = r.id,
        tripId = r.tripId,
        userId = r.userId,
        userName = r.userName,
        tripName = r.tripName,
        isAccepted = r.isAccepted,
        isRequested = r.isRequested,
        createdAt = r.createdAt;
}
