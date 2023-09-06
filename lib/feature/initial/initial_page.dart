import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/base/base_state.dart';
import '../../gen/assets.gen.dart';
import '../../routers/screen_names.dart';
import 'initila_vm.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends BaseState<InitialPage> {
  double width = 0;
  double height = 0;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        width = 200;
        height = 200;
      });
    });
    super.initState();
    _subForGoNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.lightBlue,
          child: Center(
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: width,
                height: height,
                child: SvgPicture.asset(
                  Assets.icons.logo.path,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )),
          )),
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
