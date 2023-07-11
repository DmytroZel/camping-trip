import 'package:camp_trip/data/api/firebase_trip_model/firebase_trip_api.dart';
import 'package:camp_trip/data/repository/trip_repo/trip_repo.dart';
import 'package:camp_trip/domain/model/repository/trip_model_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_trip_model/firebase_trip_model.dart';
@Injectable(as: TripRepo)
class TripRepoImpl extends TripRepo{
  final FirebaseTripApi tripApi;

  TripRepoImpl(this.tripApi);
  @override
  Future<void> addOrUpdate(TripModelRepo tripModel) {
    return tripApi.addOrUpdate(FirebaseTripModel.fromModel(tripModel));
  }

  @override
  Future<void> deleteTrip(String tripId) {
    return tripApi.deleteTrip(tripId);
  }

  @override
  Stream<List<TripModelRepo>> getTrips() {
    return tripApi.getTrips().map((event) => event.map((e) => TripModelRepo.fromFirebase(e)).toList());
  }

}