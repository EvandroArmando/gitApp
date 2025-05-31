
import 'package:flutter/material.dart';

import 'base_state.dart';

@visibleForTesting
class SuccessState<T extends Object> extends BaseState {
  final T data;
  SuccessState({required this.data});
}

