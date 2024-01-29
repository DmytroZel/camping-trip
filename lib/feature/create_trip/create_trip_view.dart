import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/common/widget/app_card.dart';
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
  void initState() {
    super.initState();
    final vm = Provider.of<CreateTripVm>(context, listen: false);
    subForGoBack(vm.onGetBack);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreateTripVm>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Створити похід"),
      ),
      body: AppCard(
        child: Column(
          children: [
            _name(),
            const SizedBox(
              height: 20,
            ),
            _date(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (vm.isProgress) return;
          _onCreateTrip();
        },
        child: vm.isProgress
            ? const CircularProgressIndicator()
            : const Icon(Icons.check),
      ),
    );
  }

  Widget _name() {
    final vm = Provider.of<CreateTripVm>(context);
    return TextField(
      onChanged: vm.onChangedName,
      decoration: const InputDecoration(
        hintText: "Назва",
      ),
    );
  }

  Widget _date() {
    final vm = Provider.of<CreateTripVm>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //start date label
                  const Text("Start date"),
                  const SizedBox(
                    height: 10,
                  ),
                  //start date field
                  InkWell(
                    onTap: _onPickStartDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            vm.startDate.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //end date label
                  const Text("End date"),
                  const SizedBox(
                    height: 10,
                  ),
                  //end date field
                  InkWell(
                    onTap: _onPickEndDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            vm.endDate.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        //period label
        Row(
          children: [
            Text("${vm.period} days"),
          ],
        )
      ],
    );
  }

  _onCreateTrip() async {
    final vm = Provider.of<CreateTripVm>(context, listen: false);
    vm.createTrip();
  }

  _onPickStartDate() async {
    final vm = Provider.of<CreateTripVm>(context, listen: false);
    final date = await showDatePicker(
      context: context,
      initialDate: vm.startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().copyWith(year: DateTime.now().year + 1),
    );
    if (date != null) {
      vm.onChangedStartDate(date);
    }
  }

  _onPickEndDate() async {
    final vm = Provider.of<CreateTripVm>(context, listen: false);
    final date = await showDatePicker(
      context: context,
      initialDate: vm.endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().copyWith(year: DateTime.now().year + 1),
    );
    if (date != null) {
      vm.onChangedEndDate(date);
    }
  }
}
