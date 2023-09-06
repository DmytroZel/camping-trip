import 'package:camp_trip/domain/model/repository/user_model_repo.dart';

class UserModel {
  String id;
  String userName;
  String email;
  bool gender;
  String? image;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.image,
    required this.gender,
  });

  UserModel.fromRepo(UserModelRepo r)
      : id = r.id,
        userName = r.userName,
        gender = r.gender ?? true,
        image = r.image,
        email = r.email;

  copyWith({
    String? id,
    String? userName,
    String? email,
    bool? gender,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  String getGender() {
    return gender ? 'Male' : 'Female';
  }
}
