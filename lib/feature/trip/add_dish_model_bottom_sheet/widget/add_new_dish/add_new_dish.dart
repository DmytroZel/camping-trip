import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/feature/trip/add_dish_model_bottom_sheet/widget/add_new_dish/widget/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/model/model/dish_model.dart';
import '../../../../../main.dart';
import 'add_new_dish_vm.dart';

class AddNewDish extends StatefulWidget {
  final ValueChanged<DishModel> onDishAdded;
  final bool isSoup;
  const AddNewDish(
      {super.key, required this.onDishAdded, required this.isSoup});

  @override
  State<AddNewDish> createState() => _AddNewDishState();
}

class _AddNewDishState extends BaseState<AddNewDish> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => serviceLocator<AddNewDishVM>(),
      child: Body(onDishAdded: widget.onDishAdded, isSoup: widget.isSoup),
    );
  }
}
