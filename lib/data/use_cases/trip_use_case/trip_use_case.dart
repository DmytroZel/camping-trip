import 'package:camp_trip/domain/model/model/trip_model.dart';

import '../../../domain/model/model/dish_model.dart';

abstract class TripUseCase {
  Future<void> addOrUpdate(TripModel tripModel);
  Future<void> deleteTrip(String tripId);
  Stream<List<TripModel>> getTrips();
  Stream<List<MemberModel>> getMember(String tripId);
  Stream<TripModel> getTrip(String id);
  Stream<List<DishModel>> getDishItems(String tripId);
  Future<void> deleteDishItem(String dishItemId, String tripId);
  Future<void> addOrUpdateDishItem(DishModel dishItemModel, String tripId);
}
