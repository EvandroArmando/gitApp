
import 'dart:async';

import 'package:flutter/material.dart';

import '../entities/observer_state_test.dart';


extension ObservableStream<T> on ObserverStateTest<T> {

  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(state);


    void _callback() {
      streamController.add(state);
    }

    addListener(_callback);
    return streamController.stream;
  }
}
