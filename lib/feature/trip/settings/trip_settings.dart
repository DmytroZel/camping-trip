import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/common/widget/app_card.dart';
import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:camp_trip/feature/trip/settings/trip_settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../routers/screen_names.dart';
import '../widget/chage_role.dart';

class TripSettings extends StatefulWidget {
  const TripSettings({super.key});

  @override
  State<TripSettings> createState() => _TripSettingsState();
}

class _TripSettingsState extends BaseState<TripSettings> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<TripSettingsVM>(context, listen: false);
    subForGoBack(vm.onGetBack);
    vm.onLoadName.stream.listen((event) {
      _nameController.text = event;
    }).toBag(bag);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripSettingsVM>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Trip settings"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          AppCard(
            child: Column(
              children: [
                _name(),
                const SizedBox(
                  height: 20,
                ),
                _date(),
                _members(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (vm.isProgress) return;
          vm.saveChanges();
        },
        child: vm.isProgress
            ? const CircularProgressIndicator()
            : const Icon(Icons.check),
      )
    );
  }

  Widget _name() {
    final vm = Provider.of<TripSettingsVM>(context);
    return TextField(
      controller: _nameController,
      onChanged: vm.onChangedName,
      decoration: const InputDecoration(
        hintText: "Name",
      ),
    );
  }

  Widget _date() {
    final vm = Provider.of<TripSettingsVM>(context);
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

  Widget _members() {
    final vm = Provider.of<TripSettingsVM>(context);
    return Column(
      children: [
        const Text("Members"),
        ExpansionTile(
          title: const Text("Members"),
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                final user = vm.members[index];
                return Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            _showChangeRoleDialog(user.role);
                          },
                          child: Text(user.userName)),
                    ),
                    Visibility(
                      visible: vm.isAdmin && !vm.isMyself(user.userId),
                      child: IconButton(
                          onPressed: () {
                            vm.onRemoveMember(user.userId);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          )),
                    ),
                  ],
                );
              },
              itemCount: vm.members.length,
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
        )
      ],
    );
  }

  _showChangeRoleDialog(int selectedRole) {
    showDialog(
        context: context,
        builder: (context) {
          return ChangeRole(
            selectedRole: selectedRole,
            onRoleChanged: (role) {
              debugPrint(role as String?);
            },
          );
        });
  }

  onInviteTap() async {
    final vm = Provider.of<TripSettingsVM>(context, listen: false);
    final UserModel? inviteUser = await context.push(ScreenNames.userList);
    if (inviteUser is UserModel) {
      vm.onUserSelected(inviteUser);
    }
  }

  _onPickStartDate() async {
    final vm = Provider.of<TripSettingsVM>(context, listen: false);
    final date = await showDatePicker(
        context: context,
        initialDate: vm.startDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().copyWith(day: DateTime.now().day + 365));
    if (date != null) {
      vm.onChangedStartDate(date);
    }
  }

  _onPickEndDate() async {
    final vm = Provider.of<TripSettingsVM>(context, listen: false);
    final date = await showDatePicker(
        context: context,
        initialDate: vm.endDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().copyWith(day: DateTime.now().day + 365));
    if (date != null) {
      vm.onChangedEndDate(date);
    }
  }
}
