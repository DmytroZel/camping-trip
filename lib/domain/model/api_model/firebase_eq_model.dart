import '../repository/eq_model_repo.dart';

class FirebaseEqModel {
  final String id;
  final String name;
  final int? type;
  final double? amount;
  final double? coefficient;
  final String? carryBy;
  final String? description;

  FirebaseEqModel({
    required this.id,
    required this.name,
    this.type,
    this.amount,
    this.coefficient,
    this.carryBy,
    this.description,
  });

  FirebaseEqModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        amount = json['amount'],
        carryBy = json['carryBy'],
        description = json['description'],
        coefficient = json['coefficient'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'amount': amount,
        'carryBy': carryBy,
        'description': description,
        'coefficient': coefficient,
      };

  FirebaseEqModel.fromRepo(EqModelRepo r)
      : id = r.id,
        name = r.name,
        type = r.type,
        amount = r.amount,
        carryBy = r.carryBy,
        description = r.description,
        coefficient = r.coefficient;
}
