import 'package:camp_trip/feature/trip/add_dish_model_botom_sheet/add_dish_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../gen/assets.gen.dart';

class ChangeDishType extends StatefulWidget {
  final DishType? selected;
  final VoidCallback onContinue;
  final ValueChanged<DishType> onDishTypeChanged;
  final List<DishType> dishTypes;

  const ChangeDishType({super.key, required this.selected, required this.onDishTypeChanged, required this.dishTypes, required this.onContinue});

  @override
  State<ChangeDishType> createState() => _ChangeDishPeriodState();
}

class _ChangeDishPeriodState extends State<ChangeDishType> {
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
          const Text('Change dish type'),
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
                    dishTypeWidget(value.name, value.type, widget.selected?.type, onDishTypeChanged: (_) {
                      widget.onDishTypeChanged(value);
                    },),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: widget.selected != null ?() {
              widget.onContinue();
            }:null,
            color: Colors.lightGreen,
            child: const Text('Continue'),
          )

        ],
      ),
    );
  }

  Widget dishTypeWidget(String dishType, int index, int? selectedDishType,
      {required ValueChanged<int> onDishTypeChanged}) {
    return Center(
      child: GestureDetector(
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
      ),
    );
  }

  String getPicture(int index) {
    switch (index) {
      case 0:
        return Assets.icons.soup.path;
      case 1:
        return Assets.icons.snack.path;
      case 2:
        return Assets.icons.porridge.path;
      case 3:
        return Assets.icons.snackType.path;
      default:
        return Assets.icons.breakfast.path;
    }
  }
}

