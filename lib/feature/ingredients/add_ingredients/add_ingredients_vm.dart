import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../data/enum/ingredients.dart';
import '../../../data/use_cases/ingredients_use_case/ingredient_use_case.dart';

@injectable
class AddIngredientsVM extends BaseVM {
  final IngredientUseCase _ingredientUseCase;

  AddIngredientsVM(this._ingredientUseCase) {
    subForIngredients();
  }

  IngredientModel? ingredientModel;
  IngredientsType selectedType = IngredientsType.bread;
  List<IngredientModel> allIngredients = [];
  String name = "";
  String? ingredientName;
  double defaultAmount = 0.0;
  double? ingredientAmount;
  StreamSubscription? subscription;

  onChangedType(IngredientsType type) {
    selectedType = type;
    notifyListeners();
  }

  onIngredientNameChanged(String value) {
    ingredientName = value;
    notifyListeners();
  }

  getIngredient() {
    ingredientModel = IngredientModel(
      name: ingredientName ?? "",
      type: selectedType.index,
      id: const Uuid().v4(),
      defaultAmount: ingredientAmount ?? 0.0,
    );
    return ingredientModel;
  }

  bool canSaveIngredient() {
    return ingredientName != null &&
        ingredientName!.isNotEmpty &&
        ingredientAmount != null &&
        ingredientAmount! > 0;
  }

  onIngredientAmountChanged(String? value) {
    ingredientAmount = double.tryParse(value ?? "0");
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

  onIngredientSelected(IngredientsType value) {
    selectedType = value;
    subForIngredients();
    notifyListeners();
  }

  subForIngredients() {
    subscription?.cancel();
    subscription =
        _ingredientUseCase.getIngredients(selectedType.index).listen((event) {
      onIngredientListChanged(event);
    }).toBag(bag);
  }

  onIngredientListChanged(List<IngredientModel> event) {
    allIngredients = event;
    notifyListeners();
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
