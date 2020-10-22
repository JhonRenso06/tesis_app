import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mr_yupi/src/model/api_exception.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/api_response.dart';

abstract class API {
  String _urlBase;
  FlutterSecureStorage storage;

  API(String baseUrl) {
    _urlBase =
        "${FlutterConfig.get('BASE_URL')}${baseUrl != null ? baseUrl : ''}";
    storage = new FlutterSecureStorage();
  }

  @protected
  Future<APIResponse<dynamic>> post(String path,
      {Map<String, dynamic> body,
      Map<String, dynamic> query,
      bool auth = false}) async {
    if (query == null) {
      query = {};
    }
    Map<String, String> headers = {"Content-Type": "application/json"};
    if (body == null) {
      body = {};
    }
    if (auth) {
      String token = await storage.read(key: "tkr_access_token");
      headers["Authorization"] = "Bearer $token";
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
      headers: headers,
    );
    var result = jsonDecode(res.body);
    try {
      if (res.statusCode == 201) {
        return APIResponse.fromMap(result);
      } else {
        return APIResponse.fromMap(result, isException: true);
      }
    } catch (_) {
      print(_);
      return APIResponse(exception: APIException(message: "Algo salió mal"));
    }
  }

  @protected
  Future<APIResponse<dynamic>> get(String path,
      {dynamic query, bool auth = false}) async {
    if (query == null) {
      query = {};
    }

    Map<String, String> headers = {"Content-Type": "application/json"};
    if (auth) {
      String token = await storage.read(key: "tkr_access_token");
      headers["Authorization"] = "Bearer $token";
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
    var res = await http.get(
      "$_urlBase$path$strQuery",
      headers: headers,
    );

    var result = jsonDecode(utf8.decode(res.bodyBytes));
    try {
      if (res.statusCode == 200) {
        return APIResponse.fromMap(result);
      } else {
        return APIResponse.fromMap(result, isException: true);
      }
    } catch (_) {
      return APIResponse(exception: APIException(message: "Algo salió mal"));
    }
  }

  @protected
  Future<APIResponse<dynamic>> put(
    String path, {
    num id,
    Map<String, dynamic> body,
    Map<String, dynamic> query,
    bool auth = false,
  }) async {
    if (query == null) {
      query = {};
    }
    Map<String, String> headers = {"Content-Type": "application/json"};
    if (body == null) {
      body = {};
    }
    if (auth) {
      String token = await storage.read(key: "tkr_access_token");
      headers["Authorization"] = "Bearer $token";
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
    var res = await http.put(
      "$_urlBase$path${id != null ? "/$id" : ''}$strQuery",
      body: jsonEncode(body),
      headers: headers,
    );
    var result = jsonDecode(res.body);
    try {
      if (res.statusCode == 200) {
        return APIResponse.fromMap(result);
      } else {
        return APIResponse.fromMap(result, isException: true);
      }
    } catch (_) {
      print(_);
      return APIResponse(exception: APIException(message: "Algo salió mal"));
    }
  }

  @protected
  Future<APIResponse<dynamic>> delete(
    String path,
    num id, {
    Map<String, dynamic> query,
    bool auth = false,
  }) async {
    if (query == null) {
      query = {};
    }
    Map<String, String> headers = {"Content-Type": "application/json"};
    if (auth) {
      String token = await storage.read(key: "tkr_access_token");
      headers["Authorization"] = "Bearer $token";
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
    var res = await http.delete(
      "$_urlBase$path/$id$strQuery",
      headers: headers,
    );
    var result = jsonDecode(res.body);
    try {
      if (res.statusCode == 200) {
        return APIResponse.fromMap(result);
      } else {
        return APIResponse.fromMap(result, isException: true);
      }
    } catch (_) {
      print(_);
      return APIResponse(exception: APIException(message: "Algo salió mal"));
    }
  }
}
