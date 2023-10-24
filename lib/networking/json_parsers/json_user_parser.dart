import 'package:networking/networking/json_parsers/json_parser.dart';

import '../json_models/users.dart';

class UserParser extends JsonParser<Users> with ObjectDecoder<Users> {
  const UserParser();
  @override
  Future<Users> parseFromJson(String json) async =>
      Users.fromJson(decodeJsonObject(json));
}
