import 'package:mr_yupi/src/model/model.dart';

class APIMessage extends Model {
  num status;
  String message;

  @override
  Model fromMap(Map<String, dynamic> data) {
    status = data['statusCode'] ?? 0;
    message = data['message'] ?? "";
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'statusCode': status,
      'message': message,
    };
  }
}
