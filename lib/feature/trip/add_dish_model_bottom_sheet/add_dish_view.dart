import 'package:camp_trip/feature/trip/add_dish_model_bottom_sheet/widget/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'add_dish_vm.dart';

class AddDishView extends StatefulWidget {
  final String tripId;
  final int day;

  const AddDishView({super.key, required this.tripId, required this.day});

  @override
  State<AddDishView> createState() => _AddDishViewState();
}

class _AddDishViewState extends State<AddDishView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => serviceLocator<AddDishVM>(),
        child: AlertDialog(
          title: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Додати страву',
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ],
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Body(
              tripId: widget.tripId,
              day: widget.day,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
          ],
        ));
  }
}
