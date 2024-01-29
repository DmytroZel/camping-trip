import 'package:camp_trip/domain/model/api_model/firebase_dish_model.dart';
import 'package:camp_trip/domain/model/api_model/firebase_eq_model.dart';
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
  Stream<List<FirebaseTripModel>> getTrips(String userId) {
    return trips.where('organizer', isEqualTo: userId).snapshots().map(
        (event) => event.docs
            .map<FirebaseTripModel>(
                (trip) => FirebaseTripModel.fromJson(trip.data()))
            .toList());
  }

  @override
  Future<void> addOrUpdateMember(FirebaseMemberModel userModel, String tripId) {
    return trips
        .doc(tripId)
        .collection('members')
        .doc(userModel.userId)
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

  @override
  Stream<FirebaseTripModel> getTripUserExist(String id) {
    return trips
        .where('members', arrayContains: id)
        .snapshots()
        .map((event) => FirebaseTripModel.fromJson(event.docs.first.data()));
  }

  @override
  Stream<List<FirebaseMemberModel>> getMember(String tripId) {
    return trips.doc(tripId).collection('members').snapshots().map((event) =>
        event.docs
            .map<FirebaseMemberModel>(
                (member) => FirebaseMemberModel.fromJson(member.data()))
            .toList());
  }

  @override
  Future<void> deleteMember(String member, String tripId) {
    return trips.doc(tripId).collection('members').doc(member).delete();
  }

  @override
  Future<void> addOrUpdateEqItem(FirebaseEqModel eqItemModel, String tripId) {
    return trips
        .doc(tripId)
        .collection('equipment')
        .doc(eqItemModel.id)
        .set(eqItemModel.toJson());
  }

  @override
  Future<void> deleteEqItem(String eqItemId, String tripId) {
    return trips.doc(tripId).collection('equipment').doc(eqItemId).delete();
  }

  @override
  Stream<List<FirebaseEqModel>> getEqItems(String tripId) {
    return trips.doc(tripId).collection('equipment').snapshots().map((event) =>
        event.docs
            .map<FirebaseEqModel>(
                (eqItem) => FirebaseEqModel.fromJson(eqItem.data()))
            .toList());
  }
}
