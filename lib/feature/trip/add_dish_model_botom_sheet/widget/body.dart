import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_dish_vm.dart';

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
    return PageView(
      children: [

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
        vm.onChangeDishPeriod(newValue!);
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
