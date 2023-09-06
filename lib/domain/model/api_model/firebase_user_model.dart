import '../repository/user_model_repo.dart';

class FirebaseUserModel {
  String id;
  String userName;
  String email;
  bool? gender;

  FirebaseUserModel(
      {required this.id,
      required this.userName,
      required this.email,
      this.gender});

  FirebaseUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        gender = json['gender'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'gender': gender,
        'email': email,
      };

  FirebaseUserModel.fromRepo(UserModelRepo r)
      : id = r.id,
        userName = r.userName,
        gender = r.gender,
        email = r.email;
}
