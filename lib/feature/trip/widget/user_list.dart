import 'package:flutter/material.dart';

import '../../../domain/model/model/user_model.dart';

class UserList extends StatefulWidget {
  final List<UserModel> users;
  final ValueChanged<UserModel> onUserSelected;
  const UserList(
      {super.key, required this.users, required this.onUserSelected});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        final user = widget.users[index];
        return ListTile(
          onTap: () {
            widget.onUserSelected(user);
          },
          title: Text(user.userName),
        );
      },
    );
  }
}
