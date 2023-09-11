import 'package:flutter/material.dart';

class ChangeRole extends StatelessWidget {
  final int selectedRole;
  final ValueChanged<int> onRoleChanged;
  const ChangeRole(
      {super.key, required this.selectedRole, required this.onRoleChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Select Role for this member'),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<int>(
              title: const Text('Member'),
              value: 0,
              groupValue: selectedRole,
              onChanged: (value) {
                onRoleChanged(value!);
              },
            ),
            RadioListTile<int>(
              title: const Text('Cook'),
              value: 2,
              groupValue: selectedRole,
              onChanged: (value) {
                onRoleChanged(value!);
              },
            ),
            RadioListTile<int>(
              title: const Text('Equipment'),
              value: 3,
              groupValue: selectedRole,
              onChanged: (value) {
                onRoleChanged(value!);
              },
            ),
            RadioListTile<int>(
              title: const Text('Deputy'),
              value: 4,
              groupValue: selectedRole,
              onChanged: (value) {
                onRoleChanged(value!);
              },
            ),
            RadioListTile<int>(
              title: const Text('Medic'),
              value: 5,
              groupValue: selectedRole,
              onChanged: (value) {
                onRoleChanged(value!);
              },
            ),
          ],
        ));
  }
}
