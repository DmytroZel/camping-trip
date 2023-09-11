import 'package:camp_trip/feature/trip/add_dish_model_botom_sheet/add_dish_vm.dart';
import 'package:flutter/material.dart';

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
          Expanded(
            child: GridView.builder(
              itemCount: widget.dishTypes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final value = widget.dishTypes[index];
                return dishTypeWidget(value.name, value.type, widget.selected?.type, onDishTypeChanged: (_) {
                  widget.onDishTypeChanged(value);
                },);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              widget.onContinue();
            },
            color: Colors.lightGreen,
            child: const Text('Continue'),
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
          children: [
            Icon(Icons.ac_unit),
            Text(dishType),
          ],
        ),
      ),
    );
  }
}

