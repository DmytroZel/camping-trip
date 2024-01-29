import 'package:camp_trip/common/base/base_vm.dart';
import 'package:camp_trip/data/use_cases/dish_use_case/dish_use_case.dart';
import 'package:camp_trip/data/use_cases/trip_use_case/trip_use_case.dart';
import 'package:camp_trip/domain/model/model/dish_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class AddDishVM extends BaseVM {
  final DishUseCase dishUseCase;
  final TripUseCase tripUseCase;

  AddDishVM(this.dishUseCase, this.tripUseCase) {
    _subForDishList();
  }

  String? dishName;
  DishModel? dishModel;
  DishPeriod? dishPeriod;
  DishType? dishType;
  List<DishType> dishesTypes = [
    DishType(0, 'Суп'),
    DishType(1, 'Сухий прийом'),
    DishType(2, 'Каша'),
    DishType(3, 'Карманка'),
  ];

  List<DishPeriod> dishPeriods = [
    DishPeriod(0, 'Сніданок'),
    DishPeriod(1, 'Обід'),
    DishPeriod(2, 'Вечеря'),
    DishPeriod(3, 'Перекукс'),
    DishPeriod(4, 'Карманка'),
  ];

  List<DishModel> dishes = [];

  dishNameChanged(String? value) {
    dishName = value;
    notifyListeners();
  }

  _subForDishList() {
    dishUseCase.getDishes().listen((event) {
      _onDishListChanged(event);
    });
  }

  _onDishListChanged(List<DishModel> dishes) {
    this.dishes = dishes;
    notifyListeners();
  }

  dishPeriodChanged(DishPeriod? value) {
    dishPeriod = value;
    notifyListeners();
  }

  dishTypeChanged(DishType? value) {
    dishType = value;
    notifyListeners();
  }

  addOrUpdateDish(String tripId, int day, DishModel dish) async {
    final local = dish.copyWith(
        name: dish.name,
        period: dishPeriod!.period,
        type: dishType!.type,
        ingredients: dish.ingredients,
        day: day,
        id: const Uuid().v4());
    await dishUseCase.addOrUpdate(dish);
    await tripUseCase.addOrUpdateDishItem(local, tripId);
  }

  onNameChanged(String val) {
    dishName = val;
    notifyListeners();
  }
}

class DishPeriod {
  final int period;
  final String name;

  DishPeriod(this.period, this.name);
}

class DishType {
  final int type;
  final String name;

  DishType(this.type, this.name);
}
