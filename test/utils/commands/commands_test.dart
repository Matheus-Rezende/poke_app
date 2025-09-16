import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

void main() {
  group('Shoud test Commands', () {
    test('Should test Command0 returns Ok', () async {
      final command0 = Command0<String>(getOkResult);

      expect(command0.completed, false);
      expect(command0.running, false);
      expect(command0.error, false);
      expect(command0.result, isNull);

      await command0.execute();

      expect(command0.running, false);
      expect(command0.error, false);
      expect(command0.result, isNotNull);

      expect(command0.result!.asOk, isInstanceOf<Ok<String>>());
    });

    test('Should test Command0 returns Error', () async {
      final command0 = Command0<bool>(getErrorResult);

      expect(command0.completed, false);
      expect(command0.running, false);
      expect(command0.error, false);
      expect(command0.result, isNull);

      await command0.execute();

      expect(command0.running, false);
      expect(command0.error, true);
      expect(command0.result, isNotNull);

      expect(command0.result!.asError, isInstanceOf<Error<bool>>());
    });

    test('Should test Command1 returns Ok', () async {
      final command1 = Command1<String, String>(getOkResult1);

      expect(command1.completed, false);
      expect(command1.running, false);
      expect(command1.error, false);
      expect(command1.result, isNull);

      await command1.execute('Parametro de entrada');

      expect(command1.completed, true);
      expect(command1.running, false);
      expect(command1.error, false);
      expect(command1.result, isNotNull);

      expect(command1.result!.asOk, isInstanceOf<Ok<String>>());

      print(command1.result!.asOk.value);
    });

    test('Should test Command1 returns Error', () async {
      final command1 = Command1<bool, String>(getErrorResult1);

      expect(command1.completed, false);
      expect(command1.running, false);
      expect(command1.error, false);
      expect(command1.result, isNull);

      await command1.execute('Parametro de entrada');

      expect(command1.running, false);
      expect(command1.error, true);
      expect(command1.result, isNotNull);

      expect(command1.result, isA<Error>());
      print(command1.error);
    });
  });
}

Future<Result<String>> getOkResult() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok('The operation has success');
}

Future<Result<bool>> getErrorResult() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception('Ocorreu um erro ao gerar o estado!'));
}

Future<Result<String>> getOkResult1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.ok('Retornou com sucesso usando parametros: $params');
}

Future<Result<bool>> getErrorResult1(String params) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return Result.error(Exception('Ocorreu um erro ao gerar o estado com parametros: $params'));
}
