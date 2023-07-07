import 'dart:async';

import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'base_vm.dart';

class BaseState<T extends StatefulWidget> extends State<T> {
  List<StreamSubscription> bag = [];
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  subForGoBack(StreamController<bool> onGetBack) {
    onGetBack.stream.listen((event) {
      context.pop(event);
    }).toBag(bag);
  }

  subForErrorMessage(StreamController<String> onErrorMessage) {
    onErrorMessage.stream.listen((error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(error));
          });
    }).toBag(bag);
  }

  handleScroll(
      {required UserScrollNotification notification, required BaseVM vm}) {
    final ScrollDirection direction = notification.direction;
    if (direction == ScrollDirection.reverse) {
      vm.hideMenu();
    } else if (direction == ScrollDirection.forward) {
      vm.showMenu();
    }
  }

  @override
  void dispose() {
    for (final sub in bag) {
      sub.cancel();
    }
    bag.clear();
    scrollController.dispose();
    super.dispose();
  }
}