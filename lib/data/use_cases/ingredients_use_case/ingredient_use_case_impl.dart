import 'package:camp_trip/data/repository/ingredient_repository/ingredient_repository.dart';
import 'package:camp_trip/data/use_cases/ingredients_use_case/ingredient_use_case.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:camp_trip/domain/model/repository/imgredient_model_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IngredientUseCase)
class IngredientUseCaseImpl extends IngredientUseCase {
  final IngredientRepository _ingredientRepository;

  IngredientUseCaseImpl(this._ingredientRepository);

  @override
  Future<void> addOrUpdate(IngredientModel ingredientModel) {
    return _ingredientRepository
        .addOrUpdate(IngredientModelRepo.fromModel(ingredientModel));
  }

  @override
  Future<void> deleteIngredient(String ingredientId) {
    return _ingredientRepository.deleteIngredient(ingredientId);
  }

  @override
  Stream<IngredientModel> getIngredient(String id) {
    return _ingredientRepository
        .getIngredient(id)
        .map((event) => IngredientModel.fromRepo(event));
  }

  @override
  Stream<List<IngredientModel>> getIngredients(int index) {
    return _ingredientRepository
        .getIngredients(index)
        .map((event) => event.map((e) => IngredientModel.fromRepo(e)).toList());
  }
}
