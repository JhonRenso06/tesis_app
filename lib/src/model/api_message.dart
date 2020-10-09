class APIMessage {
  num status;
  String message;
  APIMessage.fromMap(Map<String, dynamic> data) {
    status = data['status'];
    message = data['message'];
  }
}
