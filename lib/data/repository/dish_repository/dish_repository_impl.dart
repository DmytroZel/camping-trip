import 'package:camp_trip/domain/model/api_model/firebase_dish_model.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/repository/dish_model_repo.dart';
import '../../api/dish_item_api/dish_item_api.dart';
import 'dish_repository.dart';

@Injectable(as: DishRepository)
class DishRepositoryImpl extends DishRepository {
  final DishApi _dishApi;

  DishRepositoryImpl(this._dishApi);

  @override
  Future<void> deleteDishItem(String dishItemId) {
    return _dishApi.deleteDishItem(dishItemId);
  }

  @override
  Stream<DishModelRepo> getDishItem(String id) {
    return _dishApi.getDishItem(id).map((e) => DishModelRepo.fromFirebase(e));
  }

  @override
  Stream<List<DishModelRepo>> getDishItems() {
    return _dishApi
        .getDishItems()
        .map((e) => e.map((e) => DishModelRepo.fromFirebase(e)).toList());
  }

  @override
  Future<void> addOrUpdate(DishModelRepo dishItemModel) {
    return _dishApi.addOrUpdate(FirebaseDishModel.fromRepo(dishItemModel));
  }
}
