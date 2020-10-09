import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mr_yupi/src/model/api_exception.dart';

abstract class API {
  String _urlBase;
  FlutterSecureStorage storage;

  API(String baseUrl) {
    _urlBase =
        "${FlutterConfig.get('BASE_URL')}${baseUrl != null ? baseUrl : ''}";
    storage = new FlutterSecureStorage();
  }

  @protected
  Future<Map<dynamic, dynamic>> post(
    String path, {
    Map<String, dynamic> body,
    bool addApiKey = false,
    Map<String, dynamic> query,
  }) async {
    if (query == null) {
      query = {};
    }

    if (body == null) {
      body = {};
    }
    String strQuery = '';
    int i = 0;
    query.forEach((key, value) {
      if (i == 0) {
        strQuery += "?$key=$value";
      } else {
        strQuery += "&$key=$value";
      }
      i++;
    });
    var res = await http.post(
      "$_urlBase$path$strQuery",
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    var result = jsonDecode(res.body);
    if (res.statusCode == 201) {
      return result;
    } else {
      throw new APIException(
          statusCode: result['statusCode'], message: result['message']);
    }
  }
}
