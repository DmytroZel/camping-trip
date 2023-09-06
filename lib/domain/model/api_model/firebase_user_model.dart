import '../repository/user_model_repo.dart';

class FirebaseUserModel {
  String id;
  String userName;
  String email;

  FirebaseUserModel({
    required this.id,
    required this.userName,
    required this.email,
  });

  FirebaseUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'email': email,
      };

  FirebaseUserModel.fromRepo(UserModelRepo r)
      : id = r.id,
        userName = r.userName,
        email = r.email;
}
