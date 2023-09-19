import '../repository/dish_model_repo.dart';
import 'firebase_ingredient_model.dart';

class FirebaseDishModel {
  final String id;
  final String name;
  final int? type;
  final int? period;
  final int? day;
  final DateTime? date;
  final List<String>? steps;
  final List<FirebaseIngredientModel>? ingredients;

  FirebaseDishModel({
    required this.id,
    required this.name,
    this.type,
    this.ingredients,
    this.date,
    this.period,
    this.steps,
    this.day,
  });

  FirebaseDishModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        day = json['day'],
  period = json['period'],
        steps = json['steps'] != null
            ? List<String>.from(json['steps'].map((e) => e))
            : null,
        date = json['date'] != null ? DateTime.parse(json['date']) : null,
        ingredients = json['ingredients'] != null
            ? List<FirebaseIngredientModel>.from(json['ingredients']
                .map((e) => FirebaseIngredientModel.fromJson(e)))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'period': period,
        'day': day,
        'steps': steps,
        'date': date?.toIso8601String(),
        'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      };

  FirebaseDishModel.fromRepo(DishModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        day = r.day,
        period = r.period,
        steps = r.steps,
        date = r.date,
        ingredients = r.ingredients
            ?.map((e) => FirebaseIngredientModel.fromRepo(e))
            .toList();
}
