import 'package:camp_trip/domain/model/model/dish_model.dart';

import '../api_model/firebase_dish_model.dart';
import 'imgredient_model_repo.dart';

class DishModelRepo {
  final String id;
  final String name;
  final int? type;
  final int? period;
  final int? day;
  final List<String>? steps;
  final DateTime? date;
  final List<IngredientModelRepo>? ingredients;

  DishModelRepo(
      {required this.name,
      this.type,
      this.ingredients,
      this.date,
      this.period,
      this.day,
      this.steps,
      required this.id});

  DishModelRepo.fromFirebase(FirebaseDishModel r)
      : id = r.id,
        name = r.name,
        type = r.type,
        day = r.day,
        period = r.period,
        date = r.date,
        steps = r.steps,
        ingredients = r.ingredients
            ?.map((e) => IngredientModelRepo.fromFirebase(e))
            .toList();

  DishModelRepo.fromModel(DishModel r)
      : id = r.id,
        name = r.name,
        type = r.type,
        day = r.day,
        period = r.period,
        date = r.date,
        steps = r.steps,
        ingredients = r.ingredients
            ?.map((e) => IngredientModelRepo.fromModel(e))
            .toList();
}
