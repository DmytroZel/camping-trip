import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:camp_trip/feature/trip/pages/eq_page/eq_page.dart';
import 'package:camp_trip/feature/trip/pages/eq_page/eq_vm.dart';
import 'package:camp_trip/feature/trip/pages/members_page/members_page.dart';
import 'package:camp_trip/feature/trip/trip_vm.dart';
import 'package:camp_trip/feature/trip/widget/dish_widget.dart';
import 'package:camp_trip/routers/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/model/model/dish_model.dart';
import '../../main.dart';
import 'add_dish_model_bottom_sheet/add_dish_view.dart';

class TripView extends StatefulWidget {
  const TripView({super.key});

  @override
  State<TripView> createState() => _TripViewState();
}

class _TripViewState extends BaseState<TripView> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripVM>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(vm.trip?.name ?? ''),
        actions: [
          TextButton(
              onPressed: () {
                controller.jumpToPage(1);
              },
              child: Text('Спорядження')),
          TextButton(
              onPressed: () {
                controller.jumpToPage(0);
              },
              child: Text('Їжа')),
          TextButton(
              onPressed: () {
                controller.jumpToPage(2);
              },
              child: Text('Учасники')),
          IconButton(
              onPressed: () {
                context.push(ScreenNames.tripSettings, extra: vm.trip?.id);
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {},
        children: [
          _buildEatView(),
          _buildEquipmentView(),
          _buildMembersView(),
        ],
      ),
    );
  }

  Widget _buildEquipmentView() {
    final vm = Provider.of<TripVM>(context);
    return ChangeNotifierProvider(
        create: (context) => serviceLocator<EquipmentVM>(),
        child: EquipmentPage(
          tripId: vm.trip?.id ?? '',
        ));
  }

  Widget _buildMembersView() {
    return MembersPage();
  }

  Widget _buildEatView() {
    final vm = Provider.of<TripVM>(context);
    return ListView(
      children: [
        ExpansionTile(
            title: Text(
              "Загальна вага їжі: ${vm.getTotalWeight()}г",
              style: const TextStyle(color: Colors.black),
            ),
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = vm.getTotalList()[index];
                  final double weight = item.amount;
                  return GestureDetector(
                    onTap: () {
                      showIngredientDialog(vm.getListOfIngredients(item.name));
                    },
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text("Вага: $weightг"),
                    ),
                  );
                },
                itemCount: vm.getTotalList().length,
              )
            ]),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return tripDayWidget(index + 1, vm.getDeyDishItems(index + 1));
          },
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.getTripPeriod(),
        ),
      ],
    );
  }

  Widget tripDayWidget(int day, List<DishModel> dishes) {
    final vm = Provider.of<TripVM>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text("День $day"),
                  IconButton(
                      onPressed: () {
                        showAddDishModal(day);
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = dishes[index];
              return DishWidget(
                  ingredients: item.ingredients ?? [],
                  onAddIngredient: () {
                    onAddIngredient(item.id);
                  },
                  membersCount:
                      vm.trip?.totalMembers ?? vm.trip?.members.length ?? 1,
                  name: item.name,
                  type: vm.getDishPeriodTitle(item.type ?? 0),
                  icon: getIconFromPeriod(item.type ?? 0),
                  onEditIngredient: (ingredient) {
                    onEditIngredient(ingredient, item);
                  });
            },
            itemCount: dishes.length,
          )
        ],
      ),
    );
  }

  showAddDishModal(int day) {
    final vm = Provider.of<TripVM>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AddDishView(
        tripId: vm.trip?.id ?? '',
        day: day,
      ),
    );
  }

  IconData getIconFromPeriod(int period) {
    switch (period) {
      case 1:
        return Icons.breakfast_dining;
      case 2:
        return Icons.lunch_dining;
      case 3:
        return Icons.dinner_dining;
      default:
        return Icons.dining;
    }
  }

  onAddIngredient(String dishId) async {
    final vm = Provider.of<TripVM>(context, listen: false);
    final ingredient = await context.push(ScreenNames.ingredients);
    if (ingredient is IngredientModel) {
      vm.onAddIngredientToDish(ingredient, dishId);
    }
  }

  onEditIngredient(IngredientModel ingredient, DishModel dish) {
    final vm = Provider.of<TripVM>(context, listen: false);
    double newVal = ingredient.amount ?? ingredient.defaultAmount;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Редагувати інгредієнт"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Назва: ${ingredient.name}"),
                  Text(
                      "Вага: ${ingredient.amount ?? ingredient.defaultAmount}г на 1 людину"),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        newVal = double.parse(value);
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      vm.onEditIngredient(ingredient, newVal, dish);
                      context.pop();
                    },
                    child: const Text("Зберегти")),
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Відмінити")),
                TextButton(
                    onPressed: () {
                      vm.onDeleteIngredient(ingredient, dish);
                      context.pop();
                    },
                    child: const Text(
                      "Видалити",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
  }

  showIngredientDialog(List<IngredientModel> ingredients) {
    final vm = Provider.of<TripVM>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Інгредієнти"),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = ingredients[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                          "Вага: ${(item.amount ?? item.defaultAmount) * (vm.trip?.totalMembers ?? vm.members.length)}г"),
                    );
                  },
                  itemCount: ingredients.length,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Закрити")),
              ],
            ));
  }
}
