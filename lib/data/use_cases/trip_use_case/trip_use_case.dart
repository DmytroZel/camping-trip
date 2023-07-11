import '../../../domain/model/repository/trip_model_repo.dart';

abstract class TripUseCase{
  Future<void> addOrUpdate(TripModelRepo tripModel);
  Future<void> deleteTrip(String tripId);
  Stream<List<TripModelRepo>> getTrips();
}