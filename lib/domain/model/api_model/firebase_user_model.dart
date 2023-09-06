import '../repository/user_model_repo.dart';

class FirebaseUserModel {
  String id;
  String userName;
  String email;
  bool? gender;
  String? image;

  FirebaseUserModel({
    required this.id,
    required this.userName,
    required this.email,
    this.image,
    this.gender,
  });

  FirebaseUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        gender = json['gender'],
        email = json['email'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'gender': gender,
        'email': email,
        'image': image,
      };

  FirebaseUserModel.fromRepo(UserModelRepo r)
      : id = r.id,
        userName = r.userName,
        gender = r.gender,
        email = r.email,
        image = r.image;
}
