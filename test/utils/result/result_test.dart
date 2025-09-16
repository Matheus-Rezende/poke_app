import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/utils/result/result.dart';

void main() {
  group('Should test Result', () {
    test('Should test Ok Result', () {
      final result = Result.ok('Ok');

      expect((result as Ok).value, isA<String>());
    });

    test('Should test Ok Result with Extension', () {
      final result = 'ok'.ok();

      expect(result.asOk, isA<Ok>());
    });

    test('Should test Error Result', () {
      final result = Result.error(Exception('um Erro ocorreu'));

      expect((result as Error).error, isA<Exception>());
    });
  });
}
