import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/state_observer.dart';

import 'testable/Controller/change_state_test.dart';
import 'testable/Controller/productController.dart';
import 'testable/Controller/state_observer_teste.dart';
import 'testable/entities/base_state.dart';
import 'testable/entities/error_state.dart';
import 'testable/entities/initial_state.dart';
import 'testable/entities/loading_state.dart';
import 'testable/entities/observer_state_test.dart';
import 'testable/entities/products.dart';
import 'testable/entities/sucess_state.dart';
import 'testable/extension/observable_stream.dart';
import 'testable/extension/observable_value_notifier_teste.dart';

void main() {
  group("Testando varias coisas", () {
    test('testando OS estados de um objecto', () async {
      ProductController productController = ProductController();
      expect(productController.state, isA<InitialState>());
      productController.loadState();
      expect(productController.state, isA<SuccessState>());
    });

    test('should generate states in sequence', () async {
      final ProductController productController = ProductController();
      expect(
        productController.asStream(),
        emitsInOrder([
          isInstanceOf<InitialState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<SuccessState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<ErrorState>(),
        ]),
      );

      productController.loadState();
      productController.generateError();
    });
  });

  test('should generate ValueCounter in sequence', () async {
    final ValueNotifier<int> valueConter = ValueNotifier(0);
    expect(valueConter.asStream(), emitsInOrder([0, 1, 2, 3]));
    valueConter.value++; //1
    valueConter.value++; //2
    valueConter.value++; //3
  });
}





