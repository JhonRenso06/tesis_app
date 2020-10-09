class APIException implements Exception {
  num statusCode;
  String message;

  APIException({this.statusCode, this.message});
}
