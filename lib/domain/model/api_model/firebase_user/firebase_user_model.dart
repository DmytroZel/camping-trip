import 'package:json_annotation/json_annotation.dart';

import '../../repository/user_model.dart';


part 'firebase_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FirebaseUserModel {
  String id;
  String phone;

  FirebaseUserModel({
    required this.id,
    required this.phone,
  });

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseUserModelToJson(this);

  FirebaseUserModel.fromModel(UserModel r)
      : id = r.id,
        phone = r.phone;
}
