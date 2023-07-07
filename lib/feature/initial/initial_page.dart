
import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/base/base_state.dart';
import '../../routers/screen_names.dart';
import 'initila_vm.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends BaseState<InitialPage> {
  @override
  void initState() {
    super.initState();
    _subForGoNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreen,
        child: const Center(
          child: Text(
            "Camping trip",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  _subForGoNext() {
    final vm = Provider.of<InitialVm>(context, listen: false);
    vm.isLogIn.stream.listen((event) {
      _goToLogIn(event);
    }).toBag(bag);
    vm.startTimer();
  }

  _goToLogIn(bool isLogIn) {
    if (isLogIn) {
      context.replace(ScreenNames.main);
    } else {
      context.replace(ScreenNames.logIn);
    }
  }
}
