import 'package:camp_trip/common/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_trip_vm.dart';

class CreateTrioView extends StatefulWidget {
  const CreateTrioView({super.key});

  @override
  State<CreateTrioView> createState() => _CreateTrioViewState();
}

class _CreateTrioViewState extends BaseState<CreateTrioView> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreateTripVm>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create trip"),
      ),
      body: Stack(
        children: [
          Positioned(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    onCreateTrip();
                  },
                  child: const Text(
                    "Create Trip",
                    style: TextStyle(color: Colors.white),
                  )),
            )),
          )),
          Column(
            children: [
              TextField(
                onChanged: vm.onChangedName,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        vm.onChangedPeriod(false);
                      },
                      icon: const Icon(Icons.arrow_left)),
                  Text(vm.period.toString()),
                  IconButton(
                      onPressed: () {
                        vm.onChangedPeriod(true);
                      },
                      icon: const Icon(Icons.arrow_right))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  onCreateTrip() {
    final vm = Provider.of<CreateTripVm>(context, listen: false);
    vm.createTrip();
    goBack();
  }
}
