import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routers/screen_names.dart';
import '../trip_vm.dart';
import 'chage_role.dart';

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
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
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
              ExpansionTile(
                title: const Text("Members"),
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      final user = widget.vm.members[index];
                      return Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _showChangeRoleDialog(user.role);
                                },
                                child: Text(user.userName)),
                          ),
                          IconButton(
                              onPressed: () {
                                // widget.vm.onRemoveMember(user);
                              },
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              )),
                        ],
                      );
                    },
                    itemCount: widget.vm.members.length,
                    shrinkWrap: true,
                  ),
                  GestureDetector(
                      onTap: () {
                        onInviteTap();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Invite new members",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  _showChangeRoleDialog(int selectedRole) {
    showDialog(
        context: context,
        builder: (context) {
          return ChangeRole(
            selectedRole: selectedRole,
            onRoleChanged: (role) {
              print(role);
            },
          );
        });
  }

  onInviteTap() async {
    final UserModel? inviteUser = await context.push(ScreenNames.userList);
    if (inviteUser is UserModel) {
      widget.vm.onUserSelected(inviteUser);
    }
  }
}
