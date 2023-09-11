import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/common/widget/user_card.dart';
import 'package:camp_trip/feature/user_list/user_list_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends BaseState<UserListView> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserListVm>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change User'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final user = vm.users[index];
          return GestureDetector(
              onTap: () {
                context.pop(user);
              },
              child: UserCard(user: user));
        },
        itemCount: vm.users.length,
      ),
    );
  }
}
