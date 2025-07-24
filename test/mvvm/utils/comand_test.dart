
import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/mvvm/utils/result/comand.dart';
import 'package:git_app/mvvm/utils/result/result.dart';

void main() {
  group('should test comands', () {
 test("should test comands9 returns ok", () async {
    final command0 = Command0<String>(getOkResult);
    expect(command0.running, false);
    expect(command0.result, null);
    expect(command0.completed, false);
    expect(command0.failed, false);
    await command0.execute();
    expect(command0.running, false);
    expect((command0.result as Ok).value, "The operation has Sucess");
    expect(command0.completed, true);
    expect(command0.failed, false);
  });
  test("should test comands9 returns error", () async {
    final command0 = Command0<bool>(getErrorResult);
    expect(command0.running, false);
    expect(command0.result, null);
    expect(command0.completed, false);
    expect(command0.failed, false);
    await command0.execute();
    expect(command0.running, false);
    expect((command0.result as Error).error, isA<Exception>());
    expect(command0.completed, false);
    expect(command0.failed, true);
  });
  test('should getResult01 ', () async {
    final comand01 = Command1<String, String>(getokResult1);
    expect(comand01.running, false);
    expect(comand01.result, null);
    expect(comand01.completed, false);
    expect(comand01.failed, false);
    await comand01.execute("executando comands 1");
    expect(comand01.completed, true);
    expect(comand01.failed, false);
    expect(comand01.result, isA<Ok>());
    expect(
      (comand01.result as Ok).value,
      "The operation has Sucess with params: executando comands 1",
    );
  });

  test("should getResultError", () async {
    final comand01 = Command1<bool, String>(getErrorResult1);
    expect(comand01.running, false);
    expect(comand01.result, null);
    expect(comand01.completed, false);
    expect(comand01.failed, false);
    await comand01.execute("executando comands 1");
    expect(comand01.completed, false);
    expect(comand01.failed, true);
    expect(comand01.result, isNotNull);
    expect((comand01.result), isA<Error>());
  });
  });
 
}

Future<Result<String>> getOkResult() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok("The operation has Sucess");
}

Future<Result<bool>> getErrorResult() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception(true));
}

Future<Result<String>> getokResult1(String paraams) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok("The operation has Sucess with params: $paraams");
}

Future<Result<bool>> getErrorResult1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception("Error with params: $params"));
}
