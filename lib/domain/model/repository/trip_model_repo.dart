
import 'package:camp_trip/domain/model/api_model/firebase_trip_model/firebase_trip_model.dart';
import 'package:camp_trip/domain/model/repository/user_model_repo.dart';

import '../model/trip_model.dart';

class TripModelRepo {
  String id;
  String name;
  String period;
  String organizer;
  List<MemberModelRepo> members = [];

  TripModelRepo({
    required this.id,
    required this.name,
    required this.period,
    required this.organizer,
    required this.members,
  });

  TripModelRepo.fromFirebase(FirebaseTripModel r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members.map((e) => MemberModelRepo.fromFirebase(e)).toList();

  TripModelRepo.fromModel(TripModel r)
    : id = r.id,
      name = r.name,
      period = r.period,
      organizer = r.organizer,
      members = r.members.map((e) => MemberModelRepo.fromModel(e)).toList();
}


class MemberModelRepo{
  static const member = 0;
  static const admin = 1;
  static const cook = 2;
  static const equipment = 3;
  static const deputy = 4;
  static const medic = 5;

  int role;
  UserModelRepo user;

  MemberModelRepo({
    required this.role,
    required this.user,
  });

  MemberModelRepo.fromFirebase(FirebaseMemberModel r)
      : role = r.role,
        user = UserModelRepo.fromFirebase(r.user);

  MemberModelRepo.fromModel(MemberModel r)
      : role = r.role,
        user = UserModelRepo.fromModel(r.user);


}