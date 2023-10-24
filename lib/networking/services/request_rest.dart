import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:networking/networking/json_parsers/json_parser.dart';

class RequestRest {
  final String endpoint;
  final Map<String, dynamic> data;

  RequestRest({required this.endpoint, this.data = const {}});
  //using http package
  // final baseUrl = 'https://jsonplaceholder.typicode.com';
  // static final _client = http.Client();

  final dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 3),
  ));

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    try {
      // final response = await _client.get(Uri.parse('$baseUrl/$endpoint'));
      final response = await dio.get<String>('/$endpoint');
      // print(response.body);
      return parser.parseFromJson(response.data!);
    } catch (err) {
      throw err.toString();
    }
  }

  Future<T> executePost<T>(JsonParser<T> parser) async {
    // final response =
    //     await _client.post(Uri.parse('$baseUrl/$endpoint'), body: data);

    final response = await dio.post('/$endpoint', data: data);
    return parser.parseFromJson(response.data);
  }
}
