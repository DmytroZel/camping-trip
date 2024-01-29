import 'package:camp_trip/domain/model/api_model/firebase_trip_model.dart';

import '../model/trip_model.dart';

class TripModelRepo {
  String id;
  String name;
  String period;
  String organizer;
  DateTime startDate;
  DateTime endDate;
  int? totalMembers;
  List<String> members = [];

  TripModelRepo({
    required this.id,
    required this.name,
    required this.period,
    required this.organizer,
    required this.members,
    required this.startDate,
    this.totalMembers,
    required this.endDate,
  });

  TripModelRepo.fromFirebase(FirebaseTripModel r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members,
        startDate = r.startDate,
        totalMembers = r.totalMembers,
        endDate = r.endDate;

  TripModelRepo.fromModel(TripModel r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members,
        startDate = r.startDate,
        totalMembers = r.totalMembers,
        endDate = r.endDate;
}

class MemberModelRepo {
  static const member = 0;
  static const admin = 1;
  static const cook = 2;
  static const equipment = 3;
  static const deputy = 4;
  static const medic = 5;

  int role;
  String userName;
  String userId;

  MemberModelRepo({
    required this.role,
    required this.userName,
    required this.userId,
  });

  MemberModelRepo.fromFirebase(FirebaseMemberModel r)
      : role = r.role,
        userName = r.userName,
        userId = r.userId;

  MemberModelRepo.fromModel(MemberModel r)
      : role = r.role,
        userName = r.userName,
        userId = r.userId;
}
