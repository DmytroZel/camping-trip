import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/domain/model/model/ingridient_model.dart';
import 'package:camp_trip/feature/trip/trip_vm.dart';
import 'package:camp_trip/feature/trip/widget/dish_widget.dart';
import 'package:camp_trip/feature/trip/settings/trip_settings.dart';
import 'package:camp_trip/routers/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/model/model/dish_model.dart';
import 'add_dish_model_botom_sheet/add_dish_view.dart';

class TripView extends StatefulWidget {
  const TripView({super.key});

  @override
  State<TripView> createState() => _TripViewState();
}

class _TripViewState extends BaseState<TripView> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripVM>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(vm.trip?.name ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                context.push(ScreenNames.tripSettings, extra: vm.trip?.id);
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return tripDayWidget(index + 1, vm.getDeyDishItems(index + 1));
        },
        itemCount: vm.getTripPeriod(),
      ),
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
                  Text("Day $day"),
                  IconButton(
                      onPressed: () {
                        showAddDishModal(day);
                      },
                      icon: const Icon(Icons.add)
                  ),
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
                name: item.name,
                type: vm.getDishPeriodTitle(item.type ?? 0),
                icon: getIconFromPeriod(item.type ?? 0),
                isSelected: vm.selectedDish == item,
              );
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
}
