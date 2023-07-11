import 'package:camp_trip/common/base/base_state.dart';
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/feature/main/widet/header.dart';
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
      body: Container(
        color: Colors.lightGreen,
        child: SafeArea(
          child: Column(
            children: [
              Header(userName: vm.getUserName(),),
              const Center(
                child: Text(
                  "Camping trip",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              MaterialButton(onPressed: (){
                vm.onLogoutTap();
              }, child: Text('Sign out'),)
            ],
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
}
