import 'package:flutter/material.dart';
import 'base_state.dart';

@visibleForTesting
class ErrorState extends BaseState {
  final String message;
  ErrorState({required this.message});
}
