import 'package:mr_yupi/src/model/model.dart';

class TokenData extends Model {
  String email;
  String name;
  String lastName;
  String accessToken;
  String documento;

  TokenData({
    this.email,
    this.name,
    this.lastName,
    this.accessToken,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.email = data['email'] ?? "";
    this.name = data['name'] ?? "";
    this.lastName = data['last_name'] ?? "";
    this.documento = data['documento'] ?? "";
    this.accessToken = data['access_token'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'lastName': lastName,
      'accessToken': accessToken,
      'documento': documento,
    };
  }
}
