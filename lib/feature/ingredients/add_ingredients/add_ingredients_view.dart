import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/data/enum/ingredients.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'add_ingredients_vm.dart';

class AddIngredientsView extends StatefulWidget {
  const AddIngredientsView({super.key});

  @override
  State<AddIngredientsView> createState() => _AddIngredientsViewState();
}

class _AddIngredientsViewState extends BaseState<AddIngredientsView> {
  TextEditingController nameIngredientController = TextEditingController();
  TextEditingController amountIngredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddIngredientsVM>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text("Add ingredients"),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.2,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(IngredientsType.bread.name.toString()),
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
                          color: vm.selectedType == item
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
                  return GestureDetector(
                    onTap: () {
                      _goBack(ingredient);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(ingredient.name),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(ingredient.defaultAmount.toString()),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }

  _goBack(IngredientModel ingredientModel) {
    context.pop(ingredientModel);
  }

  onAddIngredient() async {
    final vm = Provider.of<AddIngredientsVM>(context, listen: false);
    if (vm.canSaveIngredient()) {
      context.pop(vm.getIngredient());
      nameIngredientController.clear();
      amountIngredientController.clear();
    }
  }
}
