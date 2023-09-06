import 'package:flutter/material.dart';

import '../trip_vm.dart';

class TripSettings extends StatefulWidget {
  final TripVM vm;

  const TripSettings({super.key, required this.vm});

  @override
  State<TripSettings> createState() => _TripSettingsState();
}

class _TripSettingsState extends State<TripSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Trip settings"),
        actions: [
          IconButton(
              onPressed: () {
                // widget.vm.onSave();
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          TextField(
            onChanged: widget.vm.onChangedName,
            decoration: const InputDecoration(
              hintText: "Name",
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    widget.vm.onChangedPeriod(false);
                  },
                  icon: const Icon(Icons.arrow_left)),
              Text(widget.vm.period.toString()),
              IconButton(
                  onPressed: () {
                    widget.vm.onChangedPeriod(true);
                  },
                  icon: const Icon(Icons.arrow_right))
            ],
          ),
          const Divider(),
          const Text("Users"),
        ],
      ),
    );
  }
}
