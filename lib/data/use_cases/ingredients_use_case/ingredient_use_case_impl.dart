import 'package:camp_trip/data/use_cases/ingredients_use_case/ingredient_use_case.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IngredientUseCase)
class IngredientUseCaseImpl extends IngredientUseCase {
  @override
  Future<void> addOrUpdate(IngredientModel ingredientModel) {
    // TODO: implement addOrUpdate
    throw UnimplementedError();
  }

  @override
  Future<void> deleteIngredient(String ingredientId) {
    // TODO: implement deleteIngredient
    throw UnimplementedError();
  }

  @override
  Stream<IngredientModel> getIngredient(String id) {
    // TODO: implement getIngredient
    throw UnimplementedError();
  }

  @override
  Stream<List<IngredientModel>> getIngredients() {
    // TODO: implement getIngredients
    throw UnimplementedError();
  }
}
