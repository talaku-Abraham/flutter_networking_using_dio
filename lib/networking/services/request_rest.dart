import 'package:http/http.dart' as http;
import 'package:networking/networking/json_parsers/json_parser.dart';

class RequestRest {
  final String endpoint;
  final Map<String, dynamic> data;

  RequestRest({required this.endpoint, this.data = const {}});
  final baseUrl = 'https://jsonplaceholder.typicode.com';
  static final _client = http.Client();

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    final response = await _client.get(Uri.parse('$baseUrl/$endpoint'));
    // print(response.body);
    return parser.parseFromJson(response.body);
  }

  Future<T> executePost<T>(JsonParser<T> parser) async {
    final response =
        await _client.post(Uri.parse('$baseUrl/$endpoint'), body: data);
    return parser.parseFromJson(response.body);
  }
}
