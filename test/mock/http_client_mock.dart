import 'dart:convert';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements Client {}

extension MockHttpMethods on MockHttpClient {
  void mockGet({required Uri url, required Object object, int statusCode = 200}) {
    when(
      () => get(url, headers: any(named: 'headers')),
    ).thenAnswer((_) async => http.Response(jsonEncode(object), statusCode));
  }
}
