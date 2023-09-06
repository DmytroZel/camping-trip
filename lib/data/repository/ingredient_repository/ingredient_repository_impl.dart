import 'package:camp_trip/domain/model/repository/imgredient_model_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_ingredient_model.dart';
import '../../api/ingredient_api/ingredient_api.dart';
import 'ingredient_repository.dart';

@Injectable(as: IngredientRepository)
class IngredientRepositoryImpl extends IngredientRepository {
  final IngredientApi _ingredientApi;

  IngredientRepositoryImpl(this._ingredientApi);

  @override
  Future<void> addOrUpdate(IngredientModelRepo ingredientModel) {
    return _ingredientApi
        .addOrUpdate(FirebaseIngredientModel.fromRepo(ingredientModel));
  }

  @override
  Future<void> deleteIngredient(String ingredientId) {
    return _ingredientApi.deleteIngredient(ingredientId);
  }

  @override
  Stream<IngredientModelRepo> getIngredient(String id) {
    return _ingredientApi
        .getIngredient(id)
        .map((e) => IngredientModelRepo.fromFirebase(e));
  }

  @override
  Stream<List<IngredientModelRepo>> getIngredients() {
    return _ingredientApi
        .getIngredients()
        .map((e) => e.map((e) => IngredientModelRepo.fromFirebase(e)).toList());
  }
}
