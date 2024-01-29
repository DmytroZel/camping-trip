import 'package:flutter/material.dart';

import '../../../domain/model/model/ingridient_model.dart';

class DishWidget extends StatefulWidget {
  final VoidCallback onAddIngredient;
  final String name;
  final int membersCount;
  final List<IngredientModel> ingredients;
  final String type;
  final Function(IngredientModel) onEditIngredient;
  final IconData icon;

  const DishWidget(
      {super.key,
      required this.name,
      required this.type,
      required this.icon,
      required this.onEditIngredient,
      required this.onAddIngredient,
      required this.ingredients,
      required this.membersCount});

  @override
  State<DishWidget> createState() => _DishWidgetState();
}

class _DishWidgetState extends State<DishWidget> {
  String getDayTotal(List<IngredientModel> ingredients) {
    double total = 0;
    for (var element in ingredients) {
      total = total + (element.defaultAmount * widget.membersCount);
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(widget.icon),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.type,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.ingredients.length,
            itemBuilder: (context, index) {
              final item = widget.ingredients[index];
              return ListTile(
                onTap: () {
                  widget.onEditIngredient(item);
                },
                title: Text(item.name),
                subtitle: Text(
                    "${item.amount ?? item.defaultAmount} * ${widget.membersCount} = ${((item.amount ?? item.defaultAmount) * widget.membersCount)}"),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Вага: ${getDayTotal(widget.ingredients)}",
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text('Додати інгредієнт'),
                IconButton(
                    onPressed: () {
                      widget.onAddIngredient();
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
          )
        ],
      ),
    );

    // return Column(
    //   children: [
    //     Row(
    //       children: [
    //         Icon(icon),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(name),
    //               Text(type),
    //             ],
    //           ),
    //         ),
    //         AnimatedRotation(duration: const Duration(milliseconds: 300), turns: isSelected ? 0.5 : 0, child: const Icon(Icons.keyboard_arrow_down)),
    //       ],
    //     ),
    //     Visibility(
    //       visible: isSelected,
    //       child: Column(
    //       children: [
    //       Row(
    //         children: [
    //           const Text('Add ingredients'),
    //           IconButton(onPressed: () {
    //
    //           }, icon: const Icon(Icons.add))
    //         ],
    //       )
    //       ],
    //       ),
    //     )
    //   ],
    // );
  }
}
