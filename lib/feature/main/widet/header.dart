import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  final String userName;
  const Header({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Text(userName),
        )
      ],
    );
  }
}
