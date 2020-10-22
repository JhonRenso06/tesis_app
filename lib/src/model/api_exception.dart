import 'package:mr_yupi/src/model/model.dart';

class APIException extends Model implements Exception {
  num statusCode;
  String message;

  APIException({this.statusCode, this.message});

  @override
  Model fromMap(Map<String, dynamic> data) {
    statusCode = data['statusCode'] ?? 0;
    if (data['message'] != null) {
      if (data['message'] is List) {
        message = data['message'][0];
      } else {
        message = data['message'];
      }
    } else {
      message = "";
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }
}
