import 'dart:io';

abstract class HttpService {
  Future<dynamic> get<T>(
      {required String url,
      Map<String, String> headers,
      Map<String, dynamic>? queryParameters});

  Future<dynamic> post<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String> headers,
      bool isFormUrlencoded = false});

  Future<dynamic> put<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String> headers});

  Future<dynamic> delete<T>({required String url, Map<String, String> headers});

  Future<dynamic> postFile<T>(
      {required String url,
      Map<String, String>? headers,
      required List<File> files,
      bool returnStatusCode = false});
}
