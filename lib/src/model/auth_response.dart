import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/token_data.dart';

class AuthResponse {
  TokenData token;
  APIMessage message;

  AuthResponse.fromMap(Map<String, dynamic> data) {
    this.token = TokenData.fromMap(data['data']);
    if (data['statusCode'] != null) {
      message = APIMessage.fromMap(data);
    }
  }
}
