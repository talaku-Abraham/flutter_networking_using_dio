import 'package:networking/networking/json_parsers/json_parser.dart';

import '../json_models/users.dart';

class UsersParser extends JsonParser<List<Users>>
    with ListDecoder<List<Users>> {
  const UsersParser();
  @override
  Future<List<Users>> parseFromJson(String json) async => decodeJsonList(json)
      .map((user) => Users.fromJson(user as Map<String, dynamic>))
      .toList();
}
