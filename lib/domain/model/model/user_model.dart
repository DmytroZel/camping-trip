import 'package:camp_trip/domain/model/repository/user_model_repo.dart';
import 'package:image_picker/image_picker.dart';

class UserModel {
  String id;
  String userName;
  String email;
  bool gender;
  String? image;
  XFile? imageToUpload;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    this.image,
    required this.gender,
    this.imageToUpload,
  });

  UserModel.fromRepo(UserModelRepo r)
      : id = r.id,
        userName = r.userName,
        gender = r.gender,
        image = r.image,
        email = r.email;

  copyWith({
    String? id,
    String? userName,
    String? email,
    bool? gender,
    String? image,
    XFile? imageToUpload,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      image: image ?? this.image,
      imageToUpload: imageToUpload ?? this.imageToUpload,
    );
  }

  String getGender() {
    return gender ? 'Male' : 'Female';
  }
}
