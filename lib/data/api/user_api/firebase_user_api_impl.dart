import 'package:camp_trip/data/api/user_api/firebase_user_api.dart';
import 'package:camp_trip/domain/model/api_model/firebase_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseUserAPi)
class FirebaseUserApiImpl extends FirebaseUserAPi {
  final FirebaseFirestore firebaseFirestore;
  late final users = firebaseFirestore.collection('users');

  FirebaseUserApiImpl(this.firebaseFirestore);
  @override
  Future<void> addOrUpdate(FirebaseUserModel userModel) {
    return users.doc(userModel.id).set(userModel.toJson());
  }

  @override
  Future<void> deleteUser(String userId) {
    return users.doc(userId).delete();
  }

  @override
  Future<FirebaseUserModel> getUser(String userId) {
    return users
        .doc(userId)
        .get()
        .then((value) => FirebaseUserModel.fromJson(value.data()!));
  }

  @override
  Stream<FirebaseUserModel> getMyProfileStream(String userId) {
    return users
        .doc(userId)
        .snapshots()
        .map((user) => FirebaseUserModel.fromJson(user.data()!));
  }

  @override
  Stream<List<FirebaseUserModel>> getUsers() {
    return users.snapshots().map((event) =>
        event.docs.map((e) => FirebaseUserModel.fromJson(e.data())).toList());
  }
}
