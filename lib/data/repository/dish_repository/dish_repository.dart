import 'package:camp_trip/domain/model/repository/dish_model_repo.dart';

abstract class DishRepository {
  Future<void> addOrUpdate(DishModelRepo dishItemModel);
  Future<void> deleteDishItem(String dishItemId);
  Stream<List<DishModelRepo>> getDishItems();
  Stream<DishModelRepo> getDishItem(String id);
}
