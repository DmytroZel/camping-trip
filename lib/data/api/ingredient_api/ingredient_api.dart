import '../../../domain/model/api_model/firebase_ingredient_model.dart';

abstract class IngredientApi {
  Future<void> addOrUpdate(FirebaseIngredientModel ingredientModel);
  Future<void> deleteIngredient(String ingredientId);
  Stream<List<FirebaseIngredientModel>> getIngredients(int index);
  Stream<FirebaseIngredientModel> getIngredient(String id);
}
