import 'package:camp_trip/feature/trip/widget/user_list.dart';
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
  void initState() {
    super.initState();
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.vm.onShowUserList();
        },
        child: const Icon(Icons.add),
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
          const Text("Members"),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            children: widget.vm.members
                .map((e) => Column(
                      children: [
                        Text(e.userName),
                        Text(e.role.toString()),
                        IconButton(
                            onPressed: () {
                              //TODO
                              // widget.vm.onChangedRole(e);
                            },
                            icon: const Icon(Icons.arrow_left)),
                        IconButton(
                            onPressed: () {
                              //TODO
                              // widget.vm.onChangedRole(e);
                            },
                            icon: const Icon(Icons.arrow_right))
                      ],
                    ))
                .toList(),
          ),
          widget.vm.showUserList
              ? UserList(
                  users: widget.vm.users,
                  onUserSelected: (user) {
                    widget.vm.onUserSelected(user);
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
