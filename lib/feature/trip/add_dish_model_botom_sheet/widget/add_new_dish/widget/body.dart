import 'package:camp_trip/common/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/enum/ingredients.dart';
import '../add_new_dish_vm.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends BaseState<Body> {
  TextEditingController nameIngredientController = TextEditingController();
  TextEditingController amountIngredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddNewDishVM>(context);
    return ListView(
      children: [
        TextField(
          onChanged: vm.onDishNameChanged,
          decoration: const InputDecoration(
            hintText: "Name",
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Visibility(
            visible: vm.isEditing,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.lightGreen[100],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: 300,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var item in IngredientsType.values)
                          GestureDetector(
                            onTap: () {
                              vm.onIngredientSelected(item);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                color: vm.selectedIngredient == item
                                    ? Colors.lightGreen[100]
                                    : Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Text(item.name),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: vm.ingredients.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(vm.ingredients[index].name),
                            // IconButton(
                            //   onPressed: () {
                            //     vm.onDeleteIngredient(index);
                            //   },
                            //   icon: const Icon(Icons.delete),
                            // )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
        Visibility(
          visible: !vm.isEditing,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  vm.onAddIngredientTap();
                },
                child: const Text('Add ingredient'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  onAddIngredient() async {
    final vm = Provider.of<AddNewDishVM>(context, listen: false);
    if (vm.canSaveIngredient()) {
      await vm.onAddIngredient();
      nameIngredientController.clear();
      amountIngredientController.clear();
      vm.onAddIngredientTap();
    }
  }
}
