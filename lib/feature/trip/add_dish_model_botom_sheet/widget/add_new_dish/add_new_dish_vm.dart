import 'dart:async';

import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/data/enum/ingredients.dart';
import 'package:camp_trip/data/use_cases/dish_use_case/dish_use_case.dart';
import 'package:camp_trip/data/use_cases/ingredients_use_case/ingredient_use_case.dart';
import 'package:camp_trip/domain/model/model/dish_model.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddNewDishVM extends BaseVM {
  final DishUseCase dishUseCase;
  final IngredientUseCase ingredientUseCase;

  AddNewDishVM(this.dishUseCase, this.ingredientUseCase) {
    subForIngredients();
  }

  String? dishName;
  String? ingredientName;
  double? ingredientAmount;
  DishModel? dishModel;
  bool isEditing = false;
  IngredientsType selectedIngredient = IngredientsType.bread;
  List<IngredientModel> ingredients = [];
  List<IngredientModel> allIngredients = [];
  StreamSubscription? subscription;

  onAddDish() async {
    if (dishName == null || dishName!.isEmpty) {
      return;
    }
    dishModel =
        DishModel(name: dishName!, ingredients: ingredients, id: Uuid().v4());
    await dishUseCase.addOrUpdate(dishModel!);
    dishName = null;
    ingredients = [];
    notifyListeners();
  }

  onIngredientSelected(IngredientsType value) {
    selectedIngredient = value;
    subForIngredients();
    notifyListeners();
  }

  onAddIngredientTap() {
    isEditing = !isEditing;
    notifyListeners();
  }

  onDishNameChanged(String value) {
    dishName = value;
    notifyListeners();
  }

  onIngredientAmountChanged(String? value) {
    ingredientAmount = double.tryParse(value ?? "0");
    notifyListeners();
  }

  onIngredientNameChanged(String value) {
    ingredientName = value;
    notifyListeners();
  }

  subForIngredients() {
    subscription?.cancel();
    subscription = ingredientUseCase
        .getIngredients(selectedIngredient.index)
        .listen((event) {
      onIngredientListChanged(event);
    }).toBag(bag);
  }

  onIngredientListChanged(List<IngredientModel> ingredients) {
    this.ingredients = ingredients;
    notifyListeners();
  }

  bool canSaveIngredient() {
    return ingredientName != null &&
        ingredientName!.isNotEmpty &&
        ingredientAmount != null &&
        ingredientAmount! > 0;
  }

  onAddIngredient() async {
    if (ingredientName == null ||
        ingredientName!.isEmpty ||
        ingredientAmount == null ||
        ingredientAmount == 0) {
      return;
    }
    await ingredientUseCase.addOrUpdate(IngredientModel(
      name: ingredientName!,
      type: selectedIngredient.index,
      id: const Uuid().v4(),
      defaultAmount: ingredientAmount!,
    ));
    ingredientName = null;
    ingredientAmount = null;
    notifyListeners();
  }
}
