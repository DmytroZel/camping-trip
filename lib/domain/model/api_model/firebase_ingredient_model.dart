import '../repository/imgredient_model_repo.dart';

class FirebaseIngredientModel {
  final String id;
  final String name;
  final double defaultAmount;
  final double? amount;
  final int? type;

  FirebaseIngredientModel({
    required this.id,
    required this.name,
    required this.defaultAmount,
    this.amount,
    this.type,
  });

  FirebaseIngredientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        defaultAmount = json['defaultAmount'],
        amount = json['amount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'defaultAmount': defaultAmount,
        'amount': amount,
      };

  FirebaseIngredientModel.fromRepo(IngredientModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        defaultAmount = r.defaultAmount,
        amount = r.amount;
}
