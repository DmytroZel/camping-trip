
import '../api_model/firebase_user/firebase_user_model.dart';

class UserModel {
  String id;
  String phone;

  UserModel({
    required this.id,
    required this.phone,
  });

  UserModel.fromFirebase(FirebaseUserModel r)
      : id = r.id,
        phone = r.phone;
}