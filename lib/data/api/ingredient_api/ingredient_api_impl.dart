import 'package:camp_trip/data/api/ingredient_api/ingredient_api.dart';
import 'package:camp_trip/domain/model/api_model/firebase_ingredient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IngredientApi)
class IngredientApiImpl extends IngredientApi {
  final FirebaseFirestore firebaseFirestore;
  late final ingredients = firebaseFirestore.collection('ingredients');

  IngredientApiImpl(this.firebaseFirestore);

  @override
  Future<void> addOrUpdate(FirebaseIngredientModel ingredientModel) {
    return ingredients.doc(ingredientModel.id).set(ingredientModel.toJson());
  }

  @override
  Future<void> deleteIngredient(String ingredientId) {
    return ingredients.doc(ingredientId).delete();
  }

  @override
  Stream<FirebaseIngredientModel> getIngredient(String id) {
    return ingredients
        .doc(id)
        .snapshots()
        .map((event) => FirebaseIngredientModel.fromJson(event.data()!));
  }

  @override
  Stream<List<FirebaseIngredientModel>> getIngredients(int index) {
    return ingredients
        .where(
          'type',
          isEqualTo: index,
        )
        .snapshots()
        .map((event) => event.docs
            .map((e) => FirebaseIngredientModel.fromJson(e.data()))
            .toList());
  }
}
