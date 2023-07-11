import '../../../domain/model/api_model/firebase_trip_model/firebase_trip_model.dart';

abstract class FirebaseTripApi{
Future<void> addOrUpdate(FirebaseTripModel tripModel);
Future<void> deleteTrip(String tripId);
Stream<List<FirebaseTripModel>> getTrips();
}