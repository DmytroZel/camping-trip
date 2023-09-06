import 'dart:async';

extension Bag on StreamSubscription {
  toBag(List<StreamSubscription> bag) {
    bag.add(this);
  }
}
