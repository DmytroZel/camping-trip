import 'package:camp_trip/domain/model/api_model/firebase_user_model.dart';

import '../repository/trip_model_repo.dart';

class FirebaseTripModel {
  final String id;
  final String name;
  final String period;
  final String organizer;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> members;

  FirebaseTripModel({
    required this.id,
    required this.name,
    required this.period,
    required this.organizer,
    required this.members,
    required this.startDate,
    required this.endDate,
  });

  FirebaseTripModel.fromModel(TripModelRepo r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members,
        startDate = r.startDate,
        endDate = r.endDate;

  FirebaseTripModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        period = json['period'],
        organizer = json['organizer'],
        members = List<String>.from(json['members']),
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'period': period,
        'organizer': organizer,
        'members': members.map((e) => e).toList(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };
}

class FirebaseMemberModel {
  int role;
  String userName;
  String userId;

  FirebaseMemberModel({
    required this.role,
    required this.userName,
    required this.userId,
  });

  FirebaseMemberModel.fromJson(Map<String, dynamic> json)
      : role = json['role'],
        userName = json['userName'],
        userId = json['userId'];

  Map<String, dynamic> toJson() =>
      {'role': role, 'userName': userName, 'userId': userId};

  FirebaseMemberModel.userModel(FirebaseUserModel r)
      : role = 0,
        userName = r.userName,
        userId = r.id;

  FirebaseMemberModel.fromRepo(MemberModelRepo r)
      : role = r.role,
        userName = r.userName,
        userId = r.userId;
}
