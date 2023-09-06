import '../../../domain/model/model/ingridient_model.dart';

abstract class IngredientUseCase {
  Future<void> addOrUpdate(IngredientModel ingredientModel);

  Future<void> deleteIngredient(String ingredientId);

  Stream<List<IngredientModel>> getIngredients();

  Stream<IngredientModel> getIngredient(String id);
}
