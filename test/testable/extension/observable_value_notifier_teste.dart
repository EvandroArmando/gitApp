import 'dart:async';

import 'package:flutter/material.dart';

import '../Controller/state_observer_teste.dart';

extension ObservableValueNotifierTeste<T> on ValueNotifier<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(value);

    void _callback() {
      streamController.add(value);
    }

    addListener(_callback);
    return streamController.stream;
  }
}
