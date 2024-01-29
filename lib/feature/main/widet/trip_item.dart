import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routers/screen_names.dart';

class TripItem extends StatelessWidget {
  final TripModel tripModel;
  final bool isOwner;

  const TripItem({super.key, required this.tripModel, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: InkWell(
          onTap: () {
            context.go(ScreenNames.trip, extra: tripModel.id);
          },
          child: Stack(
            children: [
              Stack(
                children: [
                  //gradient background
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightGreen,
                            Colors.green,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      tripModel.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text(
                      "${tripModel.period} days",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getDateFormat(tripModel.startDate),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          getDateFormat(tripModel.startDate),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: isOwner,
                      child: const Positioned(
                        child: Icon(Icons.star),
                        top: 10,
                        right: 10,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDateFormat(DateTime date) {
    return "${date.day}.${date.month}.${date.year}";
  }
}
