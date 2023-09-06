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

  AddDishVM(this.dishUseCase, this.tripUseCase);

  String? dishName;
  DishPeriod? dishPeriod;
  List<DishPeriod> dishPeriods = [
    DishPeriod(0, 'Breakfast'),
    DishPeriod(1, 'Lunch'),
    DishPeriod(2, 'Dinner'),
    DishPeriod(3, 'Snack'),
    DishPeriod(4, 'Dessert'),
  ];

  dishNameChanged(String? value) {
    dishName = value;
    notifyListeners();
  }

  dishPeriodChanged(DishPeriod? value) {
    dishPeriod = value;
    notifyListeners();
  }

  onChangeDishPeriod(DishPeriod value) {
    dishPeriod = value;
    notifyListeners();
  }

  addOrUpdateDish(String tripId, int day) {
    if (dishName == null || dishPeriod == null) return;
    final dish = DishModel(
        id: const Uuid().v1(),
        name: dishName!,
        type: dishPeriod!.period,
        day: day,
        ingredients: []);
    tripUseCase.addOrUpdateDishItem(dish, tripId);
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
