import 'package:camp_trip/domain/model/api_model/firebase_dish_model.dart';
import 'package:camp_trip/domain/model/api_model/firebase_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_trip_model.dart';
import 'firebase_trip_api.dart';

@Injectable(as: FirebaseTripApi)
class FirebaseTripApiImpl extends FirebaseTripApi {
  final FirebaseFirestore firebaseFirestore;
  late final trips = firebaseFirestore.collection('trips');

  FirebaseTripApiImpl(this.firebaseFirestore);

  @override
  Future<void> addOrUpdate(FirebaseTripModel tripModel) {
    return trips.doc(tripModel.id).set(tripModel.toJson());
  }

  @override
  Future<void> deleteTrip(String tripId) {
    return trips.doc(tripId).delete();
  }

  @override
  Stream<List<FirebaseTripModel>> getTrips() {
    return trips.snapshots().map((event) => event.docs
        .map<FirebaseTripModel>(
            (trip) => FirebaseTripModel.fromJson(trip.data()))
        .toList());
  }

  @override
  Future<void> addOrUpdateMember(FirebaseUserModel userModel, String tripId) {
    return trips
        .doc(tripId)
        .collection('members')
        .doc(userModel.id)
        .set(userModel.toJson());
  }

  @override
  Stream<FirebaseTripModel> getTrip(String id) {
    return trips
        .doc(id)
        .snapshots()
        .map((event) => FirebaseTripModel.fromJson(event.data()!));
  }

  @override
  Stream<List<FirebaseDishModel>> getDishItems(String tripId) {
    return trips.doc(tripId).collection('dishes').snapshots().map((event) =>
        event.docs
            .map<FirebaseDishModel>(
                (dishItem) => FirebaseDishModel.fromJson(dishItem.data()))
            .toList());
  }

  @override
  Future<void> addOrUpdateDishItem(
      FirebaseDishModel dishItemModel, String tripId) {
    return trips
        .doc(tripId)
        .collection('dishes')
        .doc(dishItemModel.id)
        .set(dishItemModel.toJson());
  }

  @override
  Future<void> deleteDishItem(String dishItemId, String tripId) {
    return trips.doc(tripId).collection('dishes').doc(dishItemId).delete();
  }
}
