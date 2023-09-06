import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../data/enum/ingredients.dart';
import '../../../data/use_cases/ingredients_use_case/ingredient_use_case.dart';

@injectable
class AddIngredientsVM extends BaseVM {
  final IngredientUseCase _ingredientUseCase;

  AddIngredientsVM(this._ingredientUseCase);

  IngredientModel? ingredientModel;
  IngredientsType selectedType = IngredientsType.bread;
  String name = "";
  double defaultAmount = 0.0;

  onChangedType(IngredientsType type) {
    selectedType = type;
    notifyListeners();
  }

  IngredientModel onGetModel() {
    IngredientModel model = IngredientModel(
      name: name,
      type: selectedType.index,
      id: const Uuid().v4(),
      defaultAmount: defaultAmount,
    );
    return model;
  }

  onChangedName(String value) {
    name = value;
    notifyListeners();
  }

  onChangedAmount(String value) {
    defaultAmount = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  bool canSave() {
    return name.isNotEmpty && defaultAmount > 0;
  }
}
