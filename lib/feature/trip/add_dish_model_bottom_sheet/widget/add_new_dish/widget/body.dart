import 'package:camp_trip/common/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/enum/ingredients.dart';
import '../../../../../../domain/model/model/dish_model.dart';
import '../add_new_dish_vm.dart';

class Body extends StatefulWidget {
  final bool isSoup;
  final ValueChanged<DishModel> onDishAdded;
  const Body({super.key, required this.onDishAdded, required this.isSoup});

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
      shrinkWrap: true,
      children: [
        TextField(
          onChanged: vm.onDishNameChanged,
          decoration: const InputDecoration(
            hintText: "Name",
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        MaterialButton(
            onPressed: vm.dishName != null && vm.ingredients.isNotEmpty
                ? () {
                    widget.onDishAdded(vm.createDishModel());
                  }
                : null,
            child: const Text("Add")),
        const SizedBox(
          height: 24,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: vm.ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = vm.ingredients[index];
            return Row(
              children: [
                Expanded(
                  child: Text(
                    ingredient.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    ingredient.amount != null
                        ? ingredient.amount.toString()
                        : ingredient.defaultAmount.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    vm.deleteIngredient(ingredient);
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            );
          },
        ),
        Container(
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
                width: MediaQuery.of(context).size.width * 0.2,
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
                          decoration: BoxDecoration(
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
                              Expanded(
                                  child: Text(
                                item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListView.builder(
                  //TODO need add local ingredients
                  shrinkWrap: true,
                  itemCount: vm.allIngredients.length + 1,
                  // itemCount: vm.allIngredients.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == vm.allIngredients.length) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: nameIngredientController,
                                onChanged: vm.onIngredientNameChanged,
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: amountIngredientController,
                                onChanged: vm.onIngredientAmountChanged,
                                decoration: const InputDecoration(
                                  hintText: "Amount",
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: onAddIngredient,
                              icon: const Icon(Icons.add),
                            )
                          ],
                        ),
                      );
                    }
                    final ingredient = vm.allIngredients[index];
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                              value: vm.isSelected(ingredient.id),
                              onChanged: (_) {
                                vm.onAddIngredientsToList(
                                    ingredient, widget.isSoup);
                              }),
                          Text(ingredient.name),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(getAmount(ingredient.defaultAmount,
                                  vm.selectedIngredient)
                              .toString()),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  double getAmount(double amount, IngredientsType type) {
    return widget.isSoup
        ? type == IngredientsType.groats
            ? amount * 0.5
            : amount
        : amount;
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
