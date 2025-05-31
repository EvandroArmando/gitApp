import 'package:flutter_test/flutter_test.dart';

import 'testable/extension/reative_primitive.dart';

void main() {
  group('Testable  obs counter', () {
    test('testable int Values', () {
      final observableValue = 0.obs();
      observableValue.state++;
      expect(observableValue.state, 1);
    });
    //  testando double

    test('testable double value', () {
      final observableValue = 0.0.obs();
      observableValue.state += 1.5;
      expect(observableValue.state, 1.5);
    });

    test('testable String value', () {
      final observableValue = 'Hello'.obs();

      observableValue.state += ' World';
      expect(observableValue.state, 'Hello World');
    });

    test('Testable bool', () {
      final observableValue = true.obs();
      observableValue.state = false;
      expect(observableValue.state, false);
    });
  });
}
