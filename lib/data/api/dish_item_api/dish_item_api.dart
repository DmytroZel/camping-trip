import '../../../domain/model/api_model/firebase_dish_model.dart';

abstract class DishApi {
  Future<void> addOrUpdate(FirebaseDishModel dishItemModel);
  Future<void> deleteDishItem(String dishItemId);
  Stream<List<FirebaseDishModel>> getDishItems();
  Stream<FirebaseDishModel> getDishItem(String id);
}
