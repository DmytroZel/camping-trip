import '../repository/dish_model_repo.dart';
import 'ingridient_model.dart';

class DishModel {
  static const breakfast = 0;
  static const lunch = 1;
  static const dinner = 2;
  static const snack = 3;
  static const dessert = 4;

  final String id;
  final String name;
  final int? type;
  final int? period;
  final int? day;
  final DateTime? date;
  final List<IngredientModel>? ingredients;
  final List<String>? steps;

  DishModel({
    required this.id,
    required this.name,
    this.type,
    this.ingredients,
    this.period,
    this.date,
    this.day,
    this.steps
  });

  DishModel.fromRepo(DishModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        day = r.day,
        period = r.period,
        date = r.date,
        steps = r.steps,
        ingredients =
            r.ingredients?.map((e) => IngredientModel.fromRepo(e)).toList();

  copyWith(
      {String? name,
      String? id,
      int? type,
      int? period,
      List<IngredientModel>? ingredients,
      DateTime? date,
      List<String>? steps,
      int? day}) {
    return DishModel(
      name: name ?? this.name,
      type: type ?? this.type,
      ingredients: ingredients ?? this.ingredients,
      date: date ?? this.date,
      day: day ?? this.day,
      id: id ?? this.id,
      steps: steps ?? this.steps,
      period: period ?? this.period,
    );
  }
}
