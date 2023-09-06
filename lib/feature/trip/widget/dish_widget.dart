import 'package:flutter/material.dart';

import '../../../domain/model/model/ingridient_model.dart';

class DishWidget extends StatelessWidget {
  final VoidCallback onAddIngredient;
  final String name;
  final List<IngredientModel> ingredients;
  final String type;
  final bool isSelected;
  final IconData icon;

  const DishWidget(
      {super.key,
      required this.name,
      required this.type,
      required this.icon,
      required this.isSelected,
      required this.onAddIngredient,
      required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  type,
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
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final item = ingredients[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.defaultAmount.toString()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text('Add ingredients'),
                IconButton(
                    onPressed: () {
                      onAddIngredient();
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
