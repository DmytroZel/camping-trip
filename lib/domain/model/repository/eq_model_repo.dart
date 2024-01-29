import '../api_model/firebase_eq_model.dart';
import '../model/eq_model.dart';

class EqModelRepo {
  final String id;
  final String name;
  final int? type;
  final double? amount;
  final double? coefficient;
  final String? carryBy;
  final String? description;

  EqModelRepo({
    required this.id,
    required this.name,
    this.type,
    this.amount,
    this.coefficient,
    this.carryBy,
    this.description,
  });

  EqModelRepo.fromFirebase(FirebaseEqModel r)
      : id = r.id,
        name = r.name,
        type = r.type,
        amount = r.amount,
        carryBy = r.carryBy,
        description = r.description,
        coefficient = r.coefficient;

  EqModelRepo.fromModel(EqModel r)
      : id = r.id,
        name = r.name,
        type = r.type,
        amount = r.amount,
        carryBy = r.carryBy,
        description = r.description,
        coefficient = r.coefficient;
}
