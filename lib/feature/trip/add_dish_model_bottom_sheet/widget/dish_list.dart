import 'package:flutter/material.dart';

import '../../../../domain/model/model/dish_model.dart';

class DishList extends StatefulWidget {
  final List<DishModel> dishes;
  final VoidCallback onAddDish;

  const DishList({super.key, required this.dishes, required this.onAddDish});

  @override
  State<DishList> createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final dish = widget.dishes[index];
            return dishWidget(dish, false);
          },
          itemCount: widget.dishes.length,
        ),
        InkWell(
            onTap: () {
              widget.onAddDish();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text('Додати страву'),
              ],
            ))
      ],
    );
  }

  Widget dishWidget(DishModel dish, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightGreen : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(dish.name),
        ],
      ),
    );
  }
}
