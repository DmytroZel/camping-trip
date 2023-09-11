import '../repository/trip_model_repo.dart';

class TripModel {
  String id;
  String name;
  String period;
  String organizer;
  DateTime startDate;
  DateTime endDate;
  List<String> members = [];

  TripModel({
    required this.id,
    required this.name,
    required this.period,
    required this.organizer,
    required this.members,
    required this.startDate,
    required this.endDate,
  });

  TripModel.fromRepo(TripModelRepo r)
      : id = r.id,
        name = r.name,
        period = r.period,
        organizer = r.organizer,
        members = r.members,
        startDate = r.startDate,
        endDate = r.endDate;

  copyWith({
    String? id,
    String? name,
    String? period,
    String? organizer,
    List<String>? members,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TripModel(
      id: id ?? this.id,
      name: name ?? this.name,
      period: period ?? this.period,
      organizer: organizer ?? this.organizer,
      members: members ?? this.members,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class MemberModel {
  static const member = 0;
  static const admin = 1;
  static const cook = 2;
  static const equipment = 3;
  static const deputy = 4;
  static const medic = 5;

  int role;
  String userName;
  String userId;

  MemberModel({
    required this.role,
    required this.userName,
    required this.userId,
  });

  MemberModel.fromRepo(MemberModelRepo r)
      : role = r.role,
        userName = r.userName,
        userId = r.userId;

  copyWith({
    int? role,
    String? userName,
    String? userId,
  }) {
    return MemberModel(
      role: role ?? this.role,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
    );
  }

  getRoleString() {
    switch (role) {
      case member:
        return 'Member';
      case admin:
        return 'Admin';
      case cook:
        return 'Cook';
      case equipment:
        return 'Equipment';
      case deputy:
        return 'Deputy';
      case medic:
        return 'Medic';
      default:
        return '';
    }
  }
}
