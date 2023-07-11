import '../api_model/firebase_user/firebase_user_model.dart';
import '../model/user_model.dart';

class UserModelRepo {
  String id;
  String userName;
  String email;

  UserModelRepo({
    required this.id,
    required this.userName,
    required this.email,
  });

  UserModelRepo.fromFirebase(FirebaseUserModel r)
      : id = r.id,
        userName = r.userName,
        email = r.email;

  UserModelRepo.fromModel(UserModel r)
      : id = r.id,
        userName = r.userName,
        email = r.email;
}