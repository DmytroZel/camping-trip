//bottom menu drawer
import 'package:camp_trip/routers/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/model/model/trip_model.dart';

class LeftMenuDrawer extends StatelessWidget {
  const LeftMenuDrawer({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.trips,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final List<TripModel> trips;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      DrawerHeader(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              context.push(ScreenNames.createTrip);
            },
            child: Text("create trip"),
            color: Colors.lightGreen.withAlpha(400),
          ),
          MaterialButton(
            onPressed: () {
              onTap();
            },
            child: Text("logout"),
            color: Colors.lightGreen.withAlpha(400),
          ),
        ],
      ))
    ]));
  }
}
