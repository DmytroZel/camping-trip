import 'package:camp_trip/domain/model/repository/dish_model_repo.dart';

import '../../../domain/model/repository/trip_model_repo.dart';

abstract class TripRepo {
  Future<void> addOrUpdate(TripModelRepo tripModel);
  Future<void> deleteTrip(String tripId);
  Stream<List<TripModelRepo>> getTrips();
  Stream<TripModelRepo> getTrip(String id);
  Stream<List<DishModelRepo>> getDishItems(String tripId);
  Future<void> deleteDishItem(String dishItemId, String tripId);
  Future<void> addOrUpdateDishItem(DishModelRepo dishItemModel, String tripId);
}
