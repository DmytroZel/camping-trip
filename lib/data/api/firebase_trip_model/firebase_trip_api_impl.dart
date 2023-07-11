import 'package:camp_trip/data/api/firebase_trip_model/firebase_trip_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_trip_model/firebase_trip_model.dart';

@Injectable(as: FirebaseTripApi)
class FirebaseTripApiImpl extends FirebaseTripApi {
  final FirebaseFirestore firebaseFirestore;
  late final users = firebaseFirestore.collection('trips');

  FirebaseTripApiImpl(this.firebaseFirestore);

  @override
  Future<void> addOrUpdate(FirebaseTripModel tripModel) {
    return users.doc(tripModel.id).set(tripModel.toJson());
  }

  @override
  Future<void> deleteTrip(String tripId) {
    return users.doc(tripId).delete();
  }

  @override
  Stream<List<FirebaseTripModel>> getTrips() {
    return users.snapshots().map((event) => event.docs
        .map<FirebaseTripModel>(
            (trip) => FirebaseTripModel.fromJson(trip.data()))
        .toList());
  }
}
