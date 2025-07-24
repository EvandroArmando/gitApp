import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/mvvm/utils/result/result.dart';

void main() {
  group('Result teste', () {
    test('Result normal', () {
      final result = Result.ok("ok");
      expect((result as Ok).value, "ok");
    });

    test('Exception normal', () {
      final error = Result.error(Exception("Error"));
      expect((error as Error).error, isA<Exception>());
    });
  });
  group('Result extension', () {
    test('result exception', () {
      final result = Result.ok("ok");
      expect(result.asOk.value, "ok");
    });
  });
}
