import '../api_model/firebase_user_model.dart';
import '../model/user_model.dart';

class UserModelRepo {
  String id;
  String userName;
  String email;
  bool gender;
  String? image;

  UserModelRepo({
    required this.id,
    required this.userName,
    required this.email,
    required this.gender,
    this.image,
  });

  UserModelRepo.fromFirebase(FirebaseUserModel r)
      : id = r.id,
        userName = r.userName,
        gender = r.gender ?? true,
        email = r.email,
        image = r.image;

  UserModelRepo.fromModel(UserModel r)
      : id = r.id,
        userName = r.userName,
        gender = r.gender,
        email = r.email,
        image = r.image;
}
