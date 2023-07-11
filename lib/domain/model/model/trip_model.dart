import 'package:camp_trip/domain/model/model/user_model.dart';

import '../repository/trip_model_repo.dart';

class TripModel{
  String id;
  String name;
  String period;
  String organizer;
  List<MemberModel> members = [];

  TripModel({
    required this.id,
    required this.name,
    required this.period,
    required this.organizer,
    required this.members,
  });

  TripModel.fromRepo(TripModelRepo r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members.map((e) => MemberModel.fromRepo(e)).toList();
}

class MemberModel{
  static const member = 0;
  static const admin = 1;
  static const cook = 2;
  static const equipment = 3;
  static const deputy = 4;
  static const medic = 5;

  int role;
  UserModel user;

  MemberModel({
    required this.role,
    required this.user,
  });

  MemberModel.fromRepo(MemberModelRepo r)
      : role = r.role,
        user = UserModel.fromRepo(r.user);
}