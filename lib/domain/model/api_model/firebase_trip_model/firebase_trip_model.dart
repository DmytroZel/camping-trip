import 'package:camp_trip/domain/model/api_model/firebase_user/firebase_user_model.dart';

import '../../repository/trip_model_repo.dart';


class FirebaseTripModel {
  final String id;
  final String name;
  final String period;
  final String organizer;
  final List<FirebaseMemberModel> members;

  FirebaseTripModel({
    required this.id,
    required this.name,
    required this.period,
    required this.organizer,
    required this.members,
  });

  FirebaseTripModel.fromModel(TripModelRepo r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members.map((e) => FirebaseMemberModel.fromRepo(e)).toList();

  FirebaseTripModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        period = json['period'],
        organizer = json['organizer'],
        members = (json['members'] as List<dynamic>)
            .map((e) => FirebaseMemberModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'period': period,
        'organizer': organizer,
        'members': members.map((e) => e.toJson()).toList(),
      };
  }




class FirebaseMemberModel{
  int role;
  FirebaseUserModel user;

  FirebaseMemberModel({
    required this.role,
    required this.user,
  });

  FirebaseMemberModel.fromRepo(MemberModelRepo r)
      : role = r.role,
        user = FirebaseUserModel.fromRepo(r.user);

  FirebaseMemberModel.fromJson(Map<String, dynamic> json)
      : role = json['role'],
        user = FirebaseUserModel.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
    'role': role,
    'user': user.toJson(),
  };
}