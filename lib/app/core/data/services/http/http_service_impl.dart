import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:poke_app/app/core/data/services/http/http_service.dart';

class HttpServiceImp implements HttpService {
  static const Duration timeLimit = Duration(seconds: 30);
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Accept-Encoding': "gzip, deflate, br",
  };

  @override
  Future get<Response>({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri uri;

    if (queryParameters != null) {
      uri = Uri.parse(url).replace(queryParameters: queryParameters);
    } else {
      uri = Uri.parse(url);
    }
    if (headers != null) {
      this.headers.addAll(headers);
    }
    var response = await http.get(uri, headers: this.headers).timeout(timeLimit);

    return response;
  }

  @override
  Future post<Response>({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    bool isFormUrlencoded = false,
  }) async {
    var uri = Uri.parse(url);

    if (headers != null) {
      this.headers.addAll(headers);
    }

    var response = await http
        .post(uri, body: isFormUrlencoded ? body : jsonEncode(body), headers: this.headers)
        .timeout(timeLimit);

    return response;
  }

  @override
  Future put<Response>({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(url);

    var response = await http.put(uri, body: jsonEncode(body), headers: headers).timeout(timeLimit);

    return response;
  }

  @override
  Future delete<Response>({required String url, Map<String, String>? headers}) async {
    var uri = Uri.parse(url);

    var response = await http.delete(uri, headers: headers).timeout(timeLimit);

    return response;
  }

  @override
  Future postFile<Response>({
    required String url,
    Map<String, String>? headers,
    required List<File> files,
    bool returnStatusCode = false,
  }) async {
    var uri = Uri.parse(url);

    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    for (var file in files) {
      request.files.add(await http.MultipartFile.fromPath('foto', file.path));
    }

    final responses = await request.send().timeout(timeLimit);

    if (returnStatusCode) {
      return responses.statusCode;
    } else {
      return responses.stream.bytesToString().catchError((e) => throw Exception(e));
    }
  }
}
