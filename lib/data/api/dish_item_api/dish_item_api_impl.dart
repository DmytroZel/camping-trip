import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/api_model/firebase_dish_model.dart';
import 'dish_item_api.dart';

@Injectable(as: DishApi)
class DishItemApiImpl extends DishApi {
  final FirebaseFirestore firebaseFirestore;
  late final dishItems = firebaseFirestore.collection('dishes');

  DishItemApiImpl(this.firebaseFirestore);

  @override
  Future<void> addOrUpdate(FirebaseDishModel dishItemModel) {
    return dishItems.doc(dishItemModel.id).set(dishItemModel.toJson());
  }

  @override
  Future<void> deleteDishItem(String dishItemId) {
    return dishItems.doc(dishItemId).delete();
  }

  @override
  Stream<List<FirebaseDishModel>> getDishItems() {
    return dishItems.snapshots().map((event) => event.docs
        .map<FirebaseDishModel>(
            (dishItem) => FirebaseDishModel.fromJson(dishItem.data()))
        .toList());
  }

  @override
  Stream<FirebaseDishModel> getDishItem(String id) {
    return dishItems
        .doc(id)
        .snapshots()
        .map((event) => FirebaseDishModel.fromJson(event.data()!));
  }
}
