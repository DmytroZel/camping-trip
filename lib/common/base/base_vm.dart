import 'dart:async';

import 'package:flutter/foundation.dart';

class BaseVM extends ChangeNotifier {
  bool _inProgress = false;
  bool _isShowMenu = false;
  bool get isProgress => _inProgress;
  bool get isShowMenu => _isShowMenu;
  List<StreamController> bagSub = [];
  List<StreamSubscription> bag = [];
  StreamController<bool> onGetBack = StreamController<bool>();
  StreamController<String> onError = StreamController<String>();

  goBack() {
    onGetBack.sink.add(true);
  }

  showProgress() {
    _inProgress = true;
    notifyListeners();
  }

  hideProgress() {
    _inProgress = false;
    notifyListeners();
  }

  showMenu() {
    _isShowMenu = true;
    notifyListeners();
  }

  hideMenu() {
    _isShowMenu = false;
    notifyListeners();
  }

  handleError(Object obj) {
    switch (obj.runtimeType) {
      default:
        if (kDebugMode) {
          print("Got error : $obj");
        }
        onError.sink.add("Got error : $obj");
    }
  }

  cleanControllers() {
    for (final item in bagSub) {
      item.close();
    }
    bagSub.clear();
  }

  cleanSub() {
    for (final item in bag) {
      item.cancel();
    }
    bag.clear();
  }

  @override
  void dispose() {
    cleanControllers();
    cleanSub();
    super.dispose();
  }
}
