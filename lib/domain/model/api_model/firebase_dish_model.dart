import '../repository/dish_model_repo.dart';
import 'firebase_ingredient_model.dart';

class FirebaseDishModel {
  final String id;
  final String name;
  final int? type;
  final int? day;
  final DateTime? date;
  final List<FirebaseIngredientModel>? ingredients;

  FirebaseDishModel({
    required this.id,
    required this.name,
    this.type,
    this.ingredients,
    this.date,
    this.day,
  });

  FirebaseDishModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        day = json['day'],
        date = json['date'] != null ? DateTime.parse(json['date']) : null,
        ingredients = json['ingredients'] != null
            ? List<FirebaseIngredientModel>.from(json['ingredients']
                .map((e) => FirebaseIngredientModel.fromJson(e)))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'day': day,
        'date': date?.toIso8601String(),
        'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      };

  FirebaseDishModel.fromRepo(DishModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        day = r.day,
        date = r.date,
        ingredients = r.ingredients
            ?.map((e) => FirebaseIngredientModel.fromRepo(e))
            .toList();
}
