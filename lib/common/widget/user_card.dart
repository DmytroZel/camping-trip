import 'package:cached_network_image/cached_network_image.dart';
import 'package:camp_trip/domain/model/model/user_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (user.image != null)
                  ClipOval(
                      child: Container(
                          color: Colors.white,
                          height: 50,
                          width: 50,
                          child:
                              CachedNetworkImage(imageUrl: user.image ?? ''))),
                if (user.image == null)
                  ClipOval(
                    child: Container(
                        height: 50, width: 50, child: const Icon(Icons.person)),
                  ),
                Text(user.userName),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
