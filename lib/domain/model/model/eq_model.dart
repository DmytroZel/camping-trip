import '../repository/eq_model_repo.dart';

class EqModel {
  final String id;
  final String name;
  final String? carryBy;
  final String? description;
  final int? type;
  final double? amount;
  final double? coefficient;

  EqModel({
    required this.id,
    required this.name,
    this.type,
    this.amount,
    this.coefficient,
    this.carryBy,
    this.description,
  });

  EqModel.fromRepo(EqModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        amount = r.amount,
        carryBy = r.carryBy,
        description = r.description,
        coefficient = r.coefficient;

  copyWith({
    String? id,
    String? name,
    int? type,
    double? amount,
    double? coefficient,
  }) {
    return EqModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      coefficient: coefficient ?? this.coefficient,
    );
  }
}
