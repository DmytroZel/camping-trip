import 'package:camp_trip/domain/model/model/dish_model.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/repository/dish_model_repo.dart';
import '../../repository/dish_repository/dish_repository.dart';
import 'dish_use_case.dart';

@Injectable(as: DishUseCase)
class DishUseCaseImpl implements DishUseCase {
  final DishRepository _dishRepository;

  DishUseCaseImpl(this._dishRepository);

  @override
  Future<void> addOrUpdate(DishModel dishModel) {
    return _dishRepository.addOrUpdate(DishModelRepo.fromModel(dishModel));
  }

  @override
  Future<void> deleteDish(String dishId) {
    return _dishRepository.deleteDishItem(dishId);
  }

  @override
  Stream<DishModel> getDish(String id) {
    return _dishRepository
        .getDishItem(id)
        .map((event) => DishModel.fromRepo(event));
  }

  @override
  Stream<List<DishModel>> getDishes() {
    return _dishRepository
        .getDishItems()
        .map((event) => event.map((e) => DishModel.fromRepo(e)).toList());
  }
}
