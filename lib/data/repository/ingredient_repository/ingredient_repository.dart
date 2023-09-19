import 'package:camp_trip/domain/model/repository/imgredient_model_repo.dart';

abstract class IngredientRepository {
  Future<void> addOrUpdate(IngredientModelRepo ingredientModel);

  Future<void> deleteIngredient(String ingredientId);

  Stream<List<IngredientModelRepo>> getIngredients(int index);

  Stream<IngredientModelRepo> getIngredient(String id);
}
