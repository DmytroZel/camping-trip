import 'package:injectable/injectable.dart';

import '../../../../common/base/base_vm.dart';
import '../../../../data/use_cases/trip_use_case/trip_use_case.dart';
import '../../../../domain/model/model/eq_model.dart';

@injectable
class EquipmentVM extends BaseVM {
  final TripUseCase _tripUseCase;

  EquipmentVM(this._tripUseCase);

  List<EqModel> eqItems = [];

  void getEqItems(String tripId) {
    _tripUseCase.getEqItems(tripId).listen((event) {
      _onChangedEq(event);
    });
  }

  _onChangedEq(List<EqModel> items) {
    eqItems = items;
    notifyListeners();
  }

  void deleteEqItem(String eqItemId, String tripId) {
    _tripUseCase.deleteEqItem(eqItemId, tripId);
  }

  Future<void> addOrUpdateEqItem(EqModel eqItemModel, String tripId) async {
    return await _tripUseCase.addOrUpdateEqItem(eqItemModel, tripId);
  }
}
