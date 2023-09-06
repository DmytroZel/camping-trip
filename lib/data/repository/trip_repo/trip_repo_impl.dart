import 'package:camp_trip/data/repository/trip_repo/trip_repo.dart';
import 'package:camp_trip/domain/model/repository/dish_model_repo.dart';
import 'package:camp_trip/domain/model/repository/trip_model_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_dish_model.dart';
import '../../../domain/model/api_model/firebase_trip_model.dart';
import '../../../domain/model/model/trip_model.dart';
import '../../api/firebase_trip_api/firebase_trip_api.dart';
import '../auth_repository/auth_repo.dart';

@Injectable(as: TripRepo)
class TripRepoImpl extends TripRepo {
  final FirebaseTripApi tripApi;
  final AuthRepo authRepo;

  TripRepoImpl(this.tripApi, this.authRepo);
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
    final user = authRepo.getId();
    return tripApi.getTrips(user).map(
        (event) => event.map((e) => TripModelRepo.fromFirebase(e)).toList());
  }

  @override
  Stream<TripModelRepo> getTrip(String id) {
    return tripApi
        .getTrip(id)
        .map((event) => TripModelRepo.fromFirebase(event));
  }

  @override
  Future<void> addOrUpdateDishItem(DishModelRepo dishItemModel, String tripId) {
    return tripApi.addOrUpdateDishItem(
        FirebaseDishModel.fromRepo(dishItemModel), tripId);
  }

  @override
  Future<void> deleteDishItem(String dishItemId, String tripId) {
    return tripApi.deleteDishItem(dishItemId, tripId);
  }

  @override
  Stream<List<DishModelRepo>> getDishItems(String tripId) {
    return tripApi.getDishItems(tripId).map(
        (event) => event.map((e) => DishModelRepo.fromFirebase(e)).toList());
  }

  @override
  Future<void> addOrUpdateMember(MemberModel modelRepo, String tripId) {
    return tripApi.addOrUpdateMember(
        FirebaseMemberModel.fromRepo(MemberModelRepo.fromModel(modelRepo)),
        tripId);
  }

  @override
  Stream<List<MemberModelRepo>> getMember(String tripId) {
    return tripApi.getMember(tripId).map(
        (event) => event.map((e) => MemberModelRepo.fromFirebase(e)).toList());
  }
}
