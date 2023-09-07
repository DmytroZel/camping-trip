import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/data/enum/ingredients.dart';
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
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddIngredientsVM>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Add ingredients"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                const Text("Select ingredient type"),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  items: [
                    for (var item in IngredientsType.values)
                      DropdownMenuItem(
                        value: item,
                        child: Text(item.name),
                      )
                  ],
                  onChanged: (value) {
                    vm.onChangedType(value ?? IngredientsType.bread);
                  },
                  value: vm.selectedType,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Enter ingredient name"),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    vm.onChangedName(value);
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter ingredient name",
                      contentPadding: EdgeInsets.all(10)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Enter ingredient quantity"),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    vm.onChangedAmount(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Enter ingredient quantity",
                      contentPadding: EdgeInsets.all(10)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                disabledColor: Colors.grey,
                disabledTextColor: Colors.white,
                minWidth: double.infinity,
                color: Colors.lightGreen,
                onPressed: vm.canSave()
                    ? () {
                        context.pop(vm.onGetModel());
                      }
                    : null,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
