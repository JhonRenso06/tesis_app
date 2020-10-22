import 'package:mr_yupi/src/api/departamento_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/departamento.dart';

class DepartamentoRepository {
  DepartamentoAPI _departamentoAPI;

  DepartamentoRepository() {
    _departamentoAPI = DepartamentoAPI();
  }

  Future<APIResponse<List<Departamento>>> getDepartamentos() async {
    return await _departamentoAPI.getDepartamentos();
  }
}
