import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_dish_vm.dart';
import 'chage_dish_type.dart';
import 'change_dish_period.dart';

class Body extends StatefulWidget {
  final String tripId;
  final int day;

  const Body({super.key, required this.tripId, required this.day});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddDishVM>(context);
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: [
        ChangeDishPeriod(selected: vm.dishPeriod, onDishTypeChanged: (value) {
          vm.dishPeriodChanged(value);
        }, dishTypes: vm.dishPeriods, onContinue: () {
          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        },),
        ChangeDishType(selected: vm.dishType, onDishTypeChanged: (DishType value) {
          vm.dishTypeChanged(value);
        }, dishTypes: vm.dishesTypes, onContinue: () {
          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn); },

        ),

      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       const Text('Add dish'),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         children: [
    //           Expanded(
    //               child: TextField(
    //             onChanged: vm.onNameChanged,
    //           )),
    //           _dishDropDownList(),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       MaterialButton(
    //         onPressed: () {
    //           vm.addOrUpdateDish(widget.tripId, widget.day);
    //         },
    //         color: Colors.lightGreen,
    //         child: const Text('Add'),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _dishDropDownList() {
    final vm = Provider.of<AddDishVM>(context);
    return DropdownButton<DishPeriod>(
      value: vm.dishPeriod,
      underline: Container(
        height: 0,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (DishPeriod? newValue) {
        // vm.onChangeDishPeriod(newValue!);
      },
      items:
          vm.dishPeriods.map<DropdownMenuItem<DishPeriod>>((DishPeriod value) {
        return DropdownMenuItem<DishPeriod>(
          value: value,
          child: Text(
            value.name,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
}
