import 'dart:convert';

import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:flutter/services.dart' show rootBundle;

class DepartamentoAPI extends API {
  DepartamentoAPI() : super('/market/departamentos');

  Future<APIResponse<List<Departamento>>> getDepartamentos() async {
    String str = await rootBundle.loadString("assets/ubigeo.json");
    List<dynamic> data = jsonDecode(str);
    List<Departamento> departamentos = List();
    data.forEach((element) {
      departamentos.add(Departamento().fromMap(element));
    });
    return APIResponse(
      data: departamentos,
      exception: null,
      message: null,
    );
  }
}
