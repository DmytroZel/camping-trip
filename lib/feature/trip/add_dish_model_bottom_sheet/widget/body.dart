import 'package:camp_trip/feature/trip/add_dish_model_bottom_sheet/widget/add_new_dish/add_new_dish.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/model/model/dish_model.dart';
import '../add_dish_vm.dart';
import 'chage_dish_type.dart';
import 'change_dish_period.dart';
import 'dish_list.dart';

class Body extends StatefulWidget {
  final String tripId;
  final int day;

  const Body({super.key, required this.tripId, required this.day});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddDishVM>(context);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        AddNewDish(
          onDishAdded: (DishModel value) async {
            await vm.addOrUpdateDish(widget.tripId, widget.day, value);
            context.pop();
          },
          isSoup: vm.dishType?.type == 0,
        ),
        ChangeDishPeriod(
          selected: vm.dishPeriod,
          onDishTypeChanged: (value) {
            vm.dishPeriodChanged(value);
          },
          dishTypes: vm.dishPeriods,
          onContinue: () {
            controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
        ),
        ChangeDishType(
          selected: vm.dishType,
          onDishTypeChanged: (DishType value) {
            vm.dishTypeChanged(value);
          },
          dishTypes: vm.dishesTypes,
          onContinue: () {
            controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
        ),
        DishList(
          dishes: vm.dishes,
          onAddDish: () {
            controller.jumpToPage(0);
          },
        ),
      ],
    );
  }
}
