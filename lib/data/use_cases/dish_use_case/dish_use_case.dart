import 'package:camp_trip/domain/model/model/dish_model.dart';

abstract class DishUseCase {
  Future<void> addOrUpdate(DishModel dishModel);

  Future<void> deleteDish(String dishId);

  Stream<List<DishModel>> getDishes();

  Stream<DishModel> getDish(String id);
}
