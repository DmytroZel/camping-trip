import '../repository/invite_user_model_repo.dart';

class FirebaseInviteUserModel {
  final String id;
  final String tripId;
  final String userId;
  final String userName;
  final String tripName;
  final bool isAccepted;
  final bool isRequested;
  final DateTime? createdAt;

  FirebaseInviteUserModel({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.userName,
    required this.tripName,
    required this.isAccepted,
    required this.isRequested,
    this.createdAt,
  });

  FirebaseInviteUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tripId = json['tripId'],
        userId = json['userId'],
        userName = json['userName'],
        tripName = json['tripName'],
        isAccepted = json['isAccepted'],
        isRequested = json['isRequested'],
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'tripId': tripId,
        'userId': userId,
        'userName': userName,
        'tripName': tripName,
        'isAccepted': isAccepted,
        'isRequested': isRequested,
        'createdAt': createdAt?.toIso8601String(),
      };

  FirebaseInviteUserModel.fromRepo(InviteUserModelRepo r)
      : id = r.id,
        tripId = r.tripId,
        userId = r.userId,
        userName = r.userName,
        tripName = r.tripName,
        isAccepted = r.isAccepted,
        isRequested = r.isRequested,
        createdAt = r.createdAt;
}
