import '../api_model/firebase_ingredient_model.dart';
import '../model/ingridient_model.dart';

class IngredientModelRepo {
  final String id;
  final String name;
  final double defaultAmount;
  final double? amount;
  final int? type;

  IngredientModelRepo({
    required this.id,
    required this.name,
    required this.defaultAmount,
    this.amount,
    this.type,
  });

  IngredientModelRepo.fromFirebase(FirebaseIngredientModel r)
      : id = r.id,
        name = r.name,
        type = r.type,
        defaultAmount = r.defaultAmount,
        amount = r.amount;

  IngredientModelRepo.fromModel(IngredientModel r)
      : id = r.id,
        name = r.name,
        type = r.type,
        defaultAmount = r.defaultAmount,
        amount = r.amount;
}
