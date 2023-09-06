import 'package:camp_trip/domain/model/api_model/firebase_dish_model.dart';

import '../../../domain/model/api_model/firebase_trip_model.dart';

abstract class FirebaseTripApi {
  Future<void> addOrUpdate(FirebaseTripModel tripModel);
  Future<void> addOrUpdateMember(FirebaseMemberModel userModel, String tripId);
  Stream<List<FirebaseMemberModel>> getMember(String tripId);
  Future<void> deleteTrip(String tripId);
  Stream<List<FirebaseTripModel>> getTrips(String userId);
  Stream<FirebaseTripModel> getTrip(String id);
  Stream<FirebaseTripModel> getTripUserExist(String id);
  Stream<List<FirebaseDishModel>> getDishItems(String tripId);
  Future<void> deleteDishItem(String dishItemId, String tripId);
  Future<void> addOrUpdateDishItem(
      FirebaseDishModel dishItemModel, String tripId);
}
