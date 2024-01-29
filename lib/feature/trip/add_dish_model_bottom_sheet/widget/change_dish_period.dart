import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';
import '../add_dish_vm.dart';

class ChangeDishPeriod extends StatefulWidget {
  final DishPeriod? selected;
  final VoidCallback onContinue;
  final ValueChanged<DishPeriod> onDishTypeChanged;
  final List<DishPeriod> dishTypes;

  const ChangeDishPeriod(
      {super.key,
      required this.selected,
      required this.onDishTypeChanged,
      required this.dishTypes,
      required this.onContinue});

  @override
  State<ChangeDishPeriod> createState() => _ChangeDishPeriodState();
}

class _ChangeDishPeriodState extends State<ChangeDishPeriod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.horizontal,
                spacing: 10,
                children: [
                  for (var value in widget.dishTypes)
                    dishTypeWidget(
                      value.name,
                      value.period,
                      widget.selected?.period,
                      onDishTypeChanged: (_) {
                        widget.onDishTypeChanged(value);
                      },
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            child: MaterialButton(
              onPressed: widget.selected != null
                  ? () {
                      widget.onContinue();
                    }
                  : null,
              color: Colors.lightGreen,
              child: const Text('Continue'),
            ),
          )
        ],
      ),
    );
  }

  Widget dishTypeWidget(String dishType, int index, int? selectedDishType,
      {required ValueChanged<int> onDishTypeChanged}) {
    return GestureDetector(
      onTap: () {
        onDishTypeChanged(index);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: index == selectedDishType ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              getPicture(index),
              height: 50,
              width: 50,
            ),
            Text(dishType),
          ],
        ),
      ),
    );
  }

  String getPicture(int index) {
    switch (index) {
      case 0:
        return Assets.icons.breakfast.path;
      case 1:
        return Assets.icons.lanch.path;
      case 2:
        return Assets.icons.dinner.path;
      case 3:
        return Assets.icons.snack.path;
      default:
        return Assets.icons.breakfast.path;
    }
  }
}
