import 'package:camp_trip/domain/model/repository/user_model_repo.dart';

class UserModel {
  String id;
  String userName;
  String email;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
  });

  UserModel.fromRepo(UserModelRepo r)
      : id = r.id,
        userName = r.userName,
        email = r.email;

  copyWith({
    String? id,
    String? userName,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }
}
