import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String role;
  const UserCard({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name),
            Text(role),
          ],
        ),
      ],
    );
  }
}
