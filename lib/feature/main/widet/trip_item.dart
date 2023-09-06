import 'package:camp_trip/domain/model/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../routers/screen_names.dart';

class TripItem extends StatelessWidget {
  final TripModel tripModel;
  final bool isOwner;

  const TripItem({super.key, required this.tripModel, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          context.push(ScreenNames.trip, extra: tripModel.id);
        },
        child: Stack(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SvgPicture.asset(
                      Assets.icons.tripBg.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.7),
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
                  Visibility(
                      visible: isOwner,
                      child: const Positioned(
                        child: Icon(Icons.star),
                        top: 10,
                        right: 10,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
