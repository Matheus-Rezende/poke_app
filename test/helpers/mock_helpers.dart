import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../mock/http_client_mock.dart';

void setUpMockGetRequest({
  required MockHttpClient client,
  required Uri url,
  required Object object,
  int statusCode = 200,
}) {
  when(() => client.get(url, headers: any(named: 'headers'))).thenAnswer((_) async {
    // 1. Primeiro, codificamos nosso objeto Dart para uma string JSON (que é UTF-8).
    final jsonString = jsonEncode(object);

    // 2. Em seguida, convertemos essa string em uma lista de bytes usando o codificador UTF-8.
    final utf8Bytes = utf8.encode(jsonString);

    // 3. Usamos o construtor `http.Response.bytes`, que é ideal para isso.
    // Ele recebe os bytes e nos permite definir os cabeçalhos (headers) corretamente.
    return http.Response.bytes(
      utf8Bytes,
      statusCode,
      // Informar o header 'content-type' é uma boa prática e simula uma API real.
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  });
}
