import 'package:poke_app/data/services/http_client_response.dart';
import 'package:poke_app/data/services/http_client_service.dart';
import 'package:http/http.dart' as http;

class HttpClientServiceImpl implements HttpClientService {
  final http.Client _client;
  final String _baseUrl;

  HttpClientServiceImpl({http.Client? client, String baseUrl = 'pokeapi.co'})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl;

  @override
  Future<HttpClientResponse> get(String path, {Map<String, String>? queryParameters}) async {
    Uri uri;
    if (path.startsWith('http://') || path.startsWith('https://')) {
      uri = Uri.parse(path);
    } else {
      uri = Uri.https(_baseUrl, path, queryParameters);
    }

    try {
      final response = await _client.get(uri);

      return HttpClientResponse(body: response.body, statusCode: response.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
