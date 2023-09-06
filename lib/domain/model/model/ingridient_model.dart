import '../repository/imgredient_model_repo.dart';

class IngredientModel {
  final String id;
  final String name;
  final double defaultAmount;
  final double? amount;
  final int? type;

  IngredientModel({
    required this.id,
    required this.name,
    required this.defaultAmount,
    this.amount,
    this.type,
  });

  IngredientModel.fromRepo(IngredientModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        defaultAmount = r.defaultAmount,
        amount = r.amount;

  copyWith(
      {String? id,
      String? name,
      double? defaultAmount,
      double? amount,
      int? type}) {
    return IngredientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        defaultAmount: defaultAmount ?? this.defaultAmount,
        amount: amount ?? this.amount);
  }
}
