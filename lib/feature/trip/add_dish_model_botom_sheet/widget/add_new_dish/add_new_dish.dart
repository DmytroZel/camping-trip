import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/feature/trip/add_dish_model_botom_sheet/widget/add_new_dish/widget/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../main.dart';
import 'add_new_dish_vm.dart';

class AddNewDish extends StatefulWidget {
  const AddNewDish({super.key});


  @override
  State<AddNewDish> createState() => _AddNewDishState();
}

class _AddNewDishState extends BaseState<AddNewDish> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => serviceLocator<AddNewDishVM>(),
        child: const Body(),
    );
  }
}
