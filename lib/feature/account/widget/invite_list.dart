import 'package:flutter/material.dart';

import '../../../domain/model/model/invite_user_model.dart';

class InviteList extends StatefulWidget {
  final List<InviteUserModel> invites;
  final Function(InviteUserModel) onAccept;
  const InviteList({super.key, required this.invites, required this.onAccept});

  @override
  State<InviteList> createState() => _InviteListState();
}

class _InviteListState extends State<InviteList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.invites.length,
      itemBuilder: (context, index) {
        final invite = widget.invites[index];
        return ListTile(
          onTap: () {
            widget.onAccept(invite);
          },
          title: Text(invite.tripName),
        );
      },
    );
  }
}
