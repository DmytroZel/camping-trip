import 'package:flutter/material.dart';

class ChangeDishType extends StatefulWidget {
  const ChangeDishType({super.key});

  @override
  State<ChangeDishType> createState() => _ChangeDishTypeState();
}

class _ChangeDishTypeState extends State<ChangeDishType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }

  Widget dishTypeWidget(String dishType, int index, int selectedDishType, ValueChanged<int> onDishTypeChanged) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.ac_unit),
          Text(dishType),


        ],
      ),
    );
  }
}
