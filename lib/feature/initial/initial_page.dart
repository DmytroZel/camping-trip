import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
  double width = 0;
  double height = 0;
  @override
  void initState() {
    super.initState();
    _subForGoNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.lightBlue,
          child: Center(
              child: SizedBox(
            width: 100,
            height: 100,
            child: LoadingIndicator(
                indicatorType: Indicator.pacman,

                /// Required, The loading type of the widget
                colors: const [Colors.white],

                /// Optional, The color collections
                strokeWidth: 2,

                /// Optional, The stroke of the line, only applicable to widget which contains line
                backgroundColor: Colors.transparent,

                /// Optional, Background of the widget
                pathBackgroundColor: Colors.transparent

                /// Optional, the stroke backgroundColor
                ),
          ))),
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
      context.go(ScreenNames.main);
    } else {
      context.go(ScreenNames.logIn);
    }
  }
}
