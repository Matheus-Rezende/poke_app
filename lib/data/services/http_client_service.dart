import 'package:poke_app/data/services/http_client_response.dart';

abstract class HttpClientService {
  Future<HttpClientResponse> get(String path, {Map<String, String>? queryParameters});
}
