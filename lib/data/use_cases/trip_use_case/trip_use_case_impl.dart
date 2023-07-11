import 'package:camp_trip/data/repository/trip_repo/trip_repo.dart';
import 'package:camp_trip/data/use_cases/trip_use_case/trip_use_case.dart';
import 'package:camp_trip/domain/model/repository/trip_model_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: TripUseCase)
class TripUseCaseImpl extends TripUseCase{
  final TripRepo tripRepo;

  TripUseCaseImpl(this.tripRepo);
  @override
  Future<void> addOrUpdate(TripModelRepo tripModel) {
    return tripRepo.addOrUpdate(tripModel);
  }

  @override
  Future<void> deleteTrip(String tripId) {
    return tripRepo.deleteTrip(tripId);

  }

  @override
  Stream<List<TripModelRepo>> getTrips() {
    return tripRepo.getTrips();
  }
}