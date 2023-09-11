import 'package:camp_trip/feature/trip/add_dish_model_botom_sheet/add_dish_vm.dart';
import 'package:flutter/material.dart';

class ChangeDishPeriod extends StatefulWidget {
  final DishPeriod? selected;
  final VoidCallback onContinue;
  final ValueChanged<DishPeriod> onDishTypeChanged;
  final List<DishPeriod> dishTypes;

  const ChangeDishPeriod({super.key, required this.selected, required this.onDishTypeChanged, required this.dishTypes, required this.onContinue});

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
                return dishTypeWidget(value.name, value.period, widget.selected?.period, onDishTypeChanged: (_) {
                  widget.onDishTypeChanged(value);
                  print('value: $value');
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
