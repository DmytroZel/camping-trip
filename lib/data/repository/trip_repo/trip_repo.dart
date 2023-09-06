import 'package:camp_trip/domain/model/repository/dish_model_repo.dart';

import '../../../domain/model/model/trip_model.dart';
import '../../../domain/model/repository/trip_model_repo.dart';

abstract class TripRepo {
  Future<void> addOrUpdate(TripModelRepo tripModel);
  Future<void> deleteTrip(String tripId);
  Stream<List<TripModelRepo>> getTrips();
  Stream<TripModelRepo> getTrip(String id);
  Stream<List<MemberModelRepo>> getMember(String tripId);
  Future<void> addOrUpdateMember(MemberModel modelRepo, String tripId);
  Stream<List<DishModelRepo>> getDishItems(String tripId);
  Future<void> deleteDishItem(String dishItemId, String tripId);
  Future<void> addOrUpdateDishItem(DishModelRepo dishItemModel, String tripId);
}
