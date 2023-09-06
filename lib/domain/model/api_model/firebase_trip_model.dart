
import '../repository/trip_model_repo.dart';

class FirebaseTripModel {
  final String id;
  final String name;
  final String period;
  final String organizer;
  final List<String> members;

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
        members = r.members;

  FirebaseTripModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        period = json['period'],
        organizer = json['organizer'],
        members = List<String>.from(json['members']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'period': period,
        'organizer': organizer,
        'members': members.map((e) => e).toList(),
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
}
