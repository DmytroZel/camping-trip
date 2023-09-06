import '../repository/invite_user_model_repo.dart';

class InviteUserModel {
  final String id;
  final String tripId;
  final String userId;
  final String userName;
  final String tripName;
  final bool isAccepted;
  final bool isRequested;
  final DateTime? createdAt;

  InviteUserModel({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.userName,
    required this.tripName,
    required this.isAccepted,
    required this.isRequested,
    this.createdAt,
  });

  InviteUserModel.fromRepo(InviteUserModelRepo r)
      : id = r.id,
        tripId = r.tripId,
        userId = r.userId,
        userName = r.userName,
        tripName = r.tripName,
        isAccepted = r.isAccepted,
        isRequested = r.isRequested,
        createdAt = r.createdAt;

  copyWith({
    String? id,
    String? tripId,
    String? userId,
    String? userName,
    String? tripName,
    bool? isAccepted,
    bool? isRequested,
    DateTime? createdAt,
  }) {
    return InviteUserModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      tripName: tripName ?? this.tripName,
      isAccepted: isAccepted ?? this.isAccepted,
      isRequested: isRequested ?? this.isRequested,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
