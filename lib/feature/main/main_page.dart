import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/feature/main/widet/drawer.dart';
import 'package:camp_trip/feature/main/widet/trip_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../routers/screen_names.dart';
import 'main_vm.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage> {
  @override
  void initState() {
    _subForGoInitial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainVm>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Camping trip"),
        actions: [
          IconButton(
            onPressed: () {
              // context.go(ScreenNames.profile);
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: LeftMenuDrawer(
          trips: vm.trips,
          onTap: () {
            vm.onLogoutTap();
          },
          icon: Icons.person,
          title: vm.userModel?.userName ?? '',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.trips.length,
                  itemBuilder: (context, index) {
                    final item = vm.trips[index];
                    return TripItem(
                      tripModel: item,
                      isOwner: vm.isTripOwner(item.organizer),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _subForGoInitial() {
    final vm = Provider.of<MainVm>(context, listen: false);
    vm.goToInitial.stream.listen((event) {
      _goToSplash();
    }).toBag(bag);
  }

  _goToSplash() {
    context.replace(ScreenNames.initial);
  }

  //TODO
  //
  // _goToTripDetail(String id) {
  //   context.go(ScreenNames.trip, extra: id);
  // }
}
